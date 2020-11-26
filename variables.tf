variable project_namespace {
  description = ""
  default     = "terraform-aws-ec2-instance"
  type        = string
}
variable project_stage {
  description = ""
  default     = "dev"
  type        = string
}
variable instance_name {
  description = ""
  default     = "ec2-instance"
  type        = string
}
variable ami {
  description = ""
  default     = "ami-0555c8a4c6ccc7aef"
  type        = string
}
variable instance_type {
  description = ""
  default     = "c4.large"
  type        = string
}
variable disable_api_termination {
  description = ""
  default     = true
  type        = bool
}
variable root_block_device_size {
  description = ""
  default     = 20
  type        = number
}
variable root_block_device_delete_on_termination {
  description = ""
  default     = true
  type        = bool
}
variable root_block_device_iops {
  description = ""
  default     = null
  type        = number
}
variable ebs_optimized {
  description = ""
  default     = null
  type        = bool
}
variable ebs_block_device {
  description = <<-EOT
This is following the parameters of `ebs_block_device` from the `terraform-aws-modules/ec2-instance/aws` module.
Extra parameter:
- `backup_volume` boolean (Optional, default is false): set whether or not to backup the volume by setting.
- `device_name` string:  (Required) The name of the device to mount.
EOT
  default     = []
  type        = list(map(string))
}
variable buildin_ebs_block_device {
  description = "EBS block devices build into the under laying AMI to be attach to the instance. Block device configurations only apply on resource creation."
  default     = []
  type        = list(map(string))
}
variable backup_buildin_volumes {
  description = "Set this `true` to backup all EBS volumes that facilitate the under laying AMI. Consider to use `backup_ami` instead."
  default     = true
  type        = bool
}
variable backup_volumes_schedule {
  description = ""
  default     = "cron(0 1 * * ? *)"
  type        = string
}
variable backup_volumes_delete_after {
  description = ""
  default     = 30
  type        = number
}
#variable backup_ami {
#  description = "Set to true to create an AMI backup."
#  default     = false
#  type        = bool
#}
variable subnet_id {
  description = ""
  default     = ""
  type        = string
}
variable private_ip {
  description = ""
  default     = ""
  type        = string
}
variable vpc_security_group_ids {
  description = ""
  default     = []
  type        = list
}
variable associate_public_ip_address {
  description = ""
  default     = false
  type        = bool
}
variable key_name {
  description = ""
  default     = ""
  type        = string
}
variable iam_instance_profile {
  description = ""
  default     = ""
  type        = string
}
variable hosted_zone_name {
  description = ""
  default     = ""
  type        = string
}
variable hosted_zone_id {
  description = ""
  default     = ""
  type        = string
}
variable route53_record {
  description = ""
  default     = ""
  type        = string
}
variable assign_eip {
  description = ""
  default     = false
  type        = bool
}
variable ebs_kms_key_arn {
  description = ""
  default     = ""
  type        = string
}
variable user_data {
  description = ""
  default     = ""
  type        = string
}
variable cpu_credits {
  type        = string
  default     = "standard"
  description = "T2/T3 Unlimited configuration. Can be `standard` and `unlimited`."
}
variable instance_tags {
  description = ""
  default     = {}
  type        = map
}
variable volume_tags {
  description = ""
  default     = {}
  type        = map
}
variable backup_tags {
  description = ""
  default     = {}
  type        = map
}

