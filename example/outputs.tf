output public_ip {
  value = module.ec2.public_ip
}
output private_ip {
  value = module.ec2.private_ip
}
# output block_device_mappings {
#   value = "${jsonencode(data.aws_ami.ami.block_device_mappings)}"
# }
output root_block_device_volume_ids {
  value = module.ec2.root_block_device_volume_ids
}
output ebs_block_device_volume_ids {
  value = module.ec2.ebs_block_device_volume_ids
}
output eip {
  value = module.ec2.eip
}
output fqdn {
  value = module.ec2.fqdn
}
