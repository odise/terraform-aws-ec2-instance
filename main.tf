provider "random" {}

resource "random_password" "backuptag" {
  length  = 16
  special = false
}

module "instance_tags" {
  source    = "git::https://github.com/cloudposse/terraform-null-label.git?ref=0.16.0"
  namespace = var.project_namespace
  stage     = var.project_stage
  name      = var.instance_name
  delimiter = "-"

  tags = var.instance_tags
}

module "volume_tags" {
  source    = "git::https://github.com/cloudposse/terraform-null-label.git?ref=0.16.0"
  namespace = var.project_namespace
  stage     = var.project_stage
  name      = var.instance_name
  delimiter = "-"

  tags = var.volume_tags
}

module "backup_tags" {
  source    = "git::https://github.com/cloudposse/terraform-null-label.git?ref=0.16.0"
  namespace = var.project_namespace
  stage     = var.project_stage
  name      = var.instance_name
  delimiter = "-"

  tags = var.backup_tags
}

module "ec2" {
  source                  = "terraform-aws-modules/ec2-instance/aws"
  version                 = "~> 2.0"
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
  ebs_optimized               = var.ebs_optimized

  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = var.root_block_device_size
      encrypted   = length(var.ebs_kms_key_arn) > 0 ? true : false
      kms_key_id  = var.ebs_kms_key_arn
    },
  ]

  # ebs_block_device = var.ebs_block_device

  tags = module.instance_tags.tags
  volume_tags = merge(module.volume_tags.tags,
    {
      BackupTag   = var.backup_volumes == true ? random_password.backuptag.result : "n/a"
      instance_id = module.ec2.id[0]
    }
  )
}

resource "aws_ebs_volume" "default" {
  count             = length(var.ebs_block_device)
  availability_zone = data.aws_subnet.selected.availability_zone
  size              = var.ebs_block_device[count.index].volume_size
  iops              = var.ebs_block_device[count.index].volume_type == "io1" ? var.ebs_block_device[count.index].iops : "0"
  type              = var.ebs_block_device[count.index].volume_type
  encrypted         = lookup(var.ebs_block_device[count.index], "encrypted", null)
  kms_key_id        = lookup(var.ebs_block_device[count.index], "kms_key_id", null)
  snapshot_id       = lookup(var.ebs_block_device[count.index], "snapshot_id", null)
  tags = merge(module.volume_tags.tags,
    {
      BackupTag   = var.backup_volumes == true ? random_password.backuptag.result : "n/a"
      device_name = var.ebs_block_device[count.index].device_name
      instance_id = module.ec2.id[0]
      count       = count.index
    }
  )
}

resource "aws_volume_attachment" "default" {
  count       = length(var.ebs_block_device)
  device_name = var.ebs_block_device[count.index].device_name
  volume_id   = aws_ebs_volume.default.*.id[count.index]
  instance_id = module.ec2.id[0]
}

module "ebs_backups" {
  enabled = var.backup_volumes

  source  = "lgallard/backup/aws"
  version = "0.2.0"
  # Plan
  plan_name = var.instance_name
  # Multiple rules using a list of maps
  rules = [
    {
      name              = "Backup rule for ${module.instance_tags.id}"
      schedule          = var.backup_volumes_schedule
      target_vault_name = "Default"
      start_window      = 120
      completion_window = 360
      lifecycle = {
        cold_storage_after = 0
        delete_after       = var.backup_volumes_delete_after
      },
      recovery_point_tags = {
        Environment = "${var.project_stage}"
      }
    },
  ]

  selections = [
    {
      name      = "tag_selection"
      resources = []
      selection_tag = {
        type  = "STRINGEQUALS"
        key   = "BackupTag"
        value = random_password.backuptag.result
      }
    }
  ]

  tags = module.backup_tags.tags
}

resource "aws_eip" "eip" {
  count    = var.assign_eip == true ? 1 : 0
  instance = module.ec2.id[0]
  vpc      = true
}

resource "aws_route53_record" "dns" {
  count   = length(var.route53_record) > 0 ? 1 : 0
  zone_id = var.hosted_zone_id
  name    = "${var.route53_record}.${var.hosted_zone_name}"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.eip[0].public_ip]
}
