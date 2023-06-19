provider "random" {}

resource "random_id" "backuptag" {
  byte_length = 16
}

module "instance_tags" {
  source    = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.21.0"
  namespace = var.project_namespace
  stage     = var.project_stage
  name      = var.instance_name
  delimiter = "-"

  tags = var.instance_tags
}

module "volume_tags" {
  source    = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.21.0"
  namespace = var.project_namespace
  stage     = var.project_stage
  name      = var.instance_name
  delimiter = "-"

  tags = var.volume_tags
}

module "backup_tags" {
  source    = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.21.0"
  namespace = var.project_namespace
  stage     = var.project_stage
  name      = var.instance_name
  delimiter = "-"

  tags = var.backup_tags
}


module "ebs_optimized" {
  source        = "terraform-aws-modules/ebs-optimized/aws"
  instance_type = var.instance_type
}

locals {
  booltranslation = {
    "0"     = false
    "1"     = true
    "true"  = true
    "false" = false
  }
}

module "ec2" {
  source                  = "terraform-aws-modules/ec2-instance/aws"
  version                 = "~> 5.0"
  instance_count          = 1
  disable_api_termination = var.disable_api_termination

  name                        = var.instance_name
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  private_ip                  = var.private_ip
  vpc_security_group_ids      = var.vpc_security_group_ids
  associate_public_ip_address = var.associate_public_ip_address
  key_name                    = var.key_name
  iam_instance_profile        = var.iam_instance_profile
  user_data_base64            = base64encode(var.user_data)
  # we use the string representation of `module.ebs_optimized.answer` because it will answer with 0 if the instance class is 
  # unknown to the module. "0" and "false" become false and "1" and "true" become true. The behavior of conversion in this 
  # direction (string to boolean) will not change in future Terraform versions. 
  ebs_optimized = var.ebs_optimized == null ? local.booltranslation[tostring(module.ebs_optimized.answer)] : var.ebs_optimized
  cpu_credits   = var.cpu_credits

  root_block_device = [
    {
      volume_type           = var.root_block_device_type
      volume_size           = var.root_block_device_size
      encrypted             = length(var.ebs_kms_key_arn) > 0 ? true : false
      kms_key_id            = var.ebs_kms_key_arn
      delete_on_termination = var.root_block_device_delete_on_termination
      iops                  = var.root_block_device_iops
    },
  ]

  ebs_block_device = [for ebs_block_device in var.buildin_ebs_block_device :
    {
      delete_on_termination = lookup(ebs_block_device, "delete_on_termination", null)
      device_name           = ebs_block_device.device_name
      encrypted             = lookup(ebs_block_device, "encrypted", null)
      iops                  = lookup(ebs_block_device, "iops", null)
      kms_key_id            = lookup(ebs_block_device, "kms_key_id", null)
      snapshot_id           = lookup(ebs_block_device, "snapshot_id", null)
      volume_size           = lookup(ebs_block_device, "volume_size", null)
      volume_type           = lookup(ebs_block_device, "volume_type", null)
    }
  ]

  tags = module.instance_tags.tags
  # this is causing prolems due to https://github.com/terraform-providers/terraform-provider-aws/issues/729
  volume_tags = merge(module.volume_tags.tags,
    {
      BackupTag = var.backup_buildin_volumes == true ? random_id.backuptag.id : "n/a"
    }
  )
}

resource "aws_ebs_volume" "default" {
  count                = length(var.ebs_block_device)
  availability_zone    = data.aws_subnet.selected.availability_zone
  size                 = var.ebs_block_device[count.index].volume_size
  iops                 = var.ebs_block_device[count.index].volume_type == "io1" || var.ebs_block_device[count.index].volume_type == "io2" ? var.ebs_block_device[count.index].iops : "0"
  type                 = var.ebs_block_device[count.index].volume_type
  encrypted            = lookup(var.ebs_block_device[count.index], "encrypted", null)
  kms_key_id           = lookup(var.ebs_block_device[count.index], "kms_key_id", null)
  snapshot_id          = lookup(var.ebs_block_device[count.index], "snapshot_id", null)
  multi_attach_enabled = lookup(var.ebs_block_device[count.index], "multi_attach_enabled", null)
  tags = merge(module.volume_tags.tags,
    {
      BackupTag = lookup(var.ebs_block_device[count.index], "backup_volume", false) == "true" ? random_id.backuptag.id : "n/a"
    }
  )
}

resource "aws_volume_attachment" "default" {
  count       = length(var.ebs_block_device)
  device_name = var.ebs_block_device[count.index].device_name
  volume_id   = aws_ebs_volume.default.*.id[count.index]
  instance_id = module.ec2.id[0]
}

locals {
  backup_volumes         = contains(var.ebs_block_device[*].backup_volume, "true")
  backup_buildin_volumes = var.backup_buildin_volumes == true
  backup_ami             = var.backup_ami
  selection = concat(
    local.backup_ami ? [{
      name          = "ami_selection"
      resources     = [module.ec2.arn[0]]
      selection_tag = {}
    }] : [],
    local.backup_volumes || local.backup_buildin_volumes ? [{
      name      = "tag_selection"
      resources = []
      selection_tag = {
        type  = "STRINGEQUALS"
        key   = "BackupTag"
        value = random_id.backuptag.id
      }
    }] : []
  )
}

module "ebs_backups" {
  enabled = local.backup_buildin_volumes || local.backup_ami || local.backup_volumes

  source  = "lgallard/backup/aws"
  version = "0.6.0"
  # Plan
  plan_name = var.instance_name
  # Multiple rules using a list of maps
  rules = [
    {
      name              = "Backup rule for ${module.instance_tags.id}"
      schedule          = var.backup_volumes_schedule
      target_vault_name = var.backup_volumes_target_vault_name
      start_window      = var.backup_volumes_start_window
      completion_window = var.backup_volumes_completion_window
      lifecycle = {
        cold_storage_after = var.backup_volumes_cold_storage_after
        delete_after       = var.backup_volumes_delete_after
      },
      recovery_point_tags = {
        Environment = var.project_stage
      }
    },
  ]

  selections = local.selection

  tags = module.backup_tags.tags
}

resource "aws_eip" "eip" {
  count    = var.assign_eip == true ? 1 : 0
  instance = module.ec2.id[0]
  vpc      = true
  tags     = module.instance_tags.tags
}

resource "aws_route53_record" "dns" {
  count   = length(var.route53_record) > 0 ? 1 : 0
  zone_id = var.hosted_zone_id
  name    = "${var.route53_record}.${var.hosted_zone_name}"
  type    = "A"
  ttl     = "300"
  records = var.assign_eip == true ? [aws_eip.eip[0].public_ip] : var.associate_public_ip_address == true ? module.ec2.public_ip : module.ec2.private_ip
}
