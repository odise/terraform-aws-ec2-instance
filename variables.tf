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
  description = "ID of AMI to use for the instance."
  type        = string
}
variable instance_type {
  description = "The type of instance to start"
  default     = "t2.medium"
  type        = string
}
variable disable_api_termination {
  description = "If true, enables EC2 Instance Termination Protection."
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
  description = "A CRON expression specifying when AWS Backup initiates a backup job."
  default     = "cron(0 1 * * ? *)"
  type        = string
}
variable backup_volumes_delete_after {
  description = "Specifies the number of days after creation that a recovery point is deleted."
  default     = 30
  type        = number
}
variable backup_volumes_cold_storage_after {
  description = "Specifies the number of days after creation that a recovery point is moved to cold storage"
  default     = 0
  type        = number
}
variable "backup_volumes_target_vault_name" {
  description = "The name of a logical container where backups are stored."
  default     = "Default"
  type        = string
}
variable "backup_volumes_start_window" {
  description = "The amount of time in minutes before beginning a backup."
  default     = 120
  type        = number
}
variable "backup_volumes_completion_window" {
  description = "The amount of time AWS Backup attempts a backup before canceling the job and returning an error."
  default     = 360
  type        = number
}
variable backup_ami {
  description = "Set to true to create an AMI backup."
  default     = false
  type        = bool
}
variable subnet_id {
  description = "The VPC Subnet ID to launch in."
  default     = ""
  type        = string
}
variable private_ip {
  description = "Private IP address to associate with the instance in a VPC."
  default     = ""
  type        = string
}
variable vpc_security_group_ids {
  description = "A list of security group IDs to associate with"
  default     = []
  type        = list(string)
}
variable associate_public_ip_address {
  description = "If true, the EC2 instance will have associated public IP address."
  default     = false
  type        = bool
}
variable key_name {
  description = "The SSH key name to use for the instance."
  default     = ""
  type        = string
}
variable iam_instance_profile {
  description = "The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile."
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
  description = "The user data to provide when launching the instance."
  default     = ""
  type        = string
}
variable cpu_credits {
  type        = string
  default     = "standard"
  description = "T2/T3 Unlimited configuration. Can be `standard` and `unlimited`."
}
variable instance_tags {
  description = "A mapping of tags to assign to the EC2 instance resource."
  default     = {}
  type        = map
}
variable volume_tags {
  description = "A mapping of tags to assign to the EBS volumes."
  default     = {}
  type        = map
}
variable backup_tags {
  description = "A mapping of tags to assign to the backup resource."
  default     = {}
  type        = map
}

