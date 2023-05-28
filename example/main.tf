locals {
  vpc_cidr     = "172.16.8.0/21"
  subnet_masks = ["172.16.8.0/23", "172.16.10.0/23", "172.16.12.0/23"]
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_kms_key" "ebs" {
  key_id = "alias/aws/ebs"
}

data "aws_security_group" "selected" {
  name   = "default"
  vpc_id = module.vpc.vpc_id
}

module "vpc" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc?ref=v4.0.2"

  name                 = "dev"
  cidr                 = local.vpc_cidr
  azs                  = data.aws_availability_zones.available.names
  public_subnets       = local.subnet_masks
  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_nat_gateway   = false
  enable_ipv6          = true
}

module ec2 {
  source = "../"

  project_namespace       = "ec2"
  project_stage           = "dev"
  instance_name           = "testinstance"
  ami                     = var.ami
  instance_type           = "m5.4xlarge"
  vpc_security_group_ids  = [data.aws_security_group.selected.id]
  disable_api_termination = "false"
  root_block_device_size  = 100
  # ebs_optimized           = false
  ebs_block_device = [
    {
      device_name   = "/dev/sdb"
      volume_type   = "gp2"
      volume_size   = 15
      iops          = 4500
      encrypted     = true
      kms_key_id    = data.aws_kms_key.ebs.arn
      backup_volume = true
    },
  ]
  # in case you want to handle AMI backed in volumes this is the place
  #  buildin_ebs_block_device = [
  #    {
  #      device_name = "/dev/sdg"
  #      volume_type = "gp2"
  #      volume_size = 40
  #      encrypted   = true
  #      kms_key_id  = data.aws_kms_key.ebs.arn
  #    },
  #  ]
  backup_buildin_volumes = true
  backup_ami             = true
  # lets test this every hour
  backup_volumes_schedule          = "cron(40 * * * ? *)"
  backup_volumes_completion_window = 120
  backup_volumes_start_window      = 60
  backup_volumes_delete_after      = 2

  subnet_id = module.vpc.public_subnets[0]
  # private_ip  =
  # vpc_security_group_ids  =
  associate_public_ip_address = true
  # key_name  =
  # iam_instance_profile  =
  assign_eip      = false
  ebs_kms_key_arn = data.aws_kms_key.ebs.arn

  instance_tags = { TAG1 = "Value" }
  volume_tags   = { VOLUME_TAG = "Value" }
  # backup_tags  =
}

