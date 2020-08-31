variable project_namespace { default = "terraform-aws-ec2-instance" }
variable project_stage { default = "dev" }
variable instance_name { default = "ec2-instance" }
variable ami { default = "ami-0555c8a4c6ccc7aef" }
variable instance_type { default = "c4.large" }
variable disable_api_termination { default = true }
variable root_block_device_size { default = 20 }
variable root_block_device_delete_on_termination { default = true }
variable root_block_device_iops { default = null }
variable ebs_optimized { default = null }
variable ebs_block_device { default = [] }
variable buildin_ebs_block_device { default = [] }
variable backup_volumes { default = true }
variable backup_volumes_schedule { default = "cron(0 1 * * ? *)" }
variable backup_volumes_delete_after { default = 30 }
variable subnet_id { default = "" }
variable private_ip { default = "" }
variable vpc_security_group_ids { default = [] }
variable associate_public_ip_address { default = false }
variable key_name { default = "" }
variable iam_instance_profile { default = "" }
variable hosted_zone_name { default = "" }
variable hosted_zone_id { default = "" }
variable route53_record { default = "" }
variable assign_eip { default = false }
variable ebs_kms_key_arn { default = "" }
variable user_data { default = "" }
variable cpu_credits {
  type        = string
  default     = "standard"
  description = "T2/T3 Unlimited configuration. Can be `standard` and `unlimited`."
}

variable instance_tags { default = {} }
variable volume_tags { default = {} }
variable backup_tags { default = {} }

