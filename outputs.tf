output "id" {
  description = "List of IDs of instances"
  value       = module.ec2.id
}

output "arn" {
  description = "List of ARNs of instances"
  value       = module.ec2.arn
}

output "availability_zone" {
  description = "List of availability zones of instances"
  value       = module.ec2.availability_zone
}

output "password_data" {
  description = "List of Base-64 encoded encrypted password data for the instance"
  value       = module.ec2.password_data
}

output "public_dns" {
  description = "List of public DNS names assigned to the instances. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC"
  value       = module.ec2.public_dns
}

output "public_ip" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = module.ec2.public_ip
}

output "ipv6_addresses" {
  description = "List of assigned IPv6 addresses of instances"
  value       = module.ec2.ipv6_addresses
}

output "primary_network_interface_id" {
  description = "List of IDs of the primary network interface of instances"
  value       = module.ec2.primary_network_interface_id
}

output "private_dns" {
  description = "List of private DNS names assigned to the instances. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC"
  value       = module.ec2.private_dns
}

output "private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value       = module.ec2.private_ip
}

output "instance_state" {
  description = "List of instance states of instances"
  value       = module.ec2.instance_state
}

output "root_block_device_volume_ids" {
  description = "List of volume IDs of root block devices of instances"
  value       = flatten(module.ec2.root_block_device_volume_ids)
}

output "ebs_block_device_volume_ids" {
  description = "List of volume IDs of EBS block devices of instances"
  value       = aws_ebs_volume.default.*.id
}

output "instance_tags" {
  value = module.instance_tags.tags
}

output "volume_tags" {
  value = module.volume_tags.tags
}

output "backup_tags" {
  value = module.backup_tags.tags
}

output "backup_vault_id" {
  description = "The name of the vault"
  value       = module.ebs_backups.vault_id
}

output "backup_vault_arn" {
  description = "The ARN of the vault"
  value       = module.ebs_backups.vault_arn
}

# Plan
output "backup_plan_id" {
  description = "The id of the backup plan"
  value       = module.ebs_backups.plan_id
}

output "backup_plan_arn" {
  description = "The ARN of the backup plan"
  value       = module.ebs_backups.plan_arn
}

output "backup_plan_version" {
  description = "Unique, randomly generated, Unicode, UTF-8 encoded string that serves as the version ID of the backup plan"
  value       = module.ebs_backups.plan_version
}
