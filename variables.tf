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
  description = ""
  default     = []
  type        = list
}
variable buildin_ebs_block_device {
  description = ""
  default     = []
  type        = list
}
variable backup_volumes {
  description = ""
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

