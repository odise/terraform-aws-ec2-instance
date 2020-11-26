# terraform-aws-ec2-instance

This module deploys an EC2 instance along with EBS snapshotting via AWS Backup, Elastic IP and Route53 DNS record. It uses the following Terraform modules underneath:

* [terraform-aws-modules/ec2-instance/aws](https://github.com/terraform-aws-modules/terraform-aws-ec2-instance/)
* [lgallard/backup/aws](https://github.com/lgallard/terraform-aws-backup)

# Usage
<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.6, < 0.14 |
| aws | >= 2.54.0 |
| random | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.54.0 |
| random | ~> 2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ami | n/a | `string` | `"ami-0555c8a4c6ccc7aef"` | no |
| assign\_eip | n/a | `bool` | `false` | no |
| associate\_public\_ip\_address | n/a | `bool` | `false` | no |
| backup\_ami | Set to true to create an AMI backup. | `bool` | `false` | no |
| backup\_buildin\_volumes | Set this `true` to backup all EBS volumes that facilitate the under laying AMI. Consider to use `backup_ami` instead. | `bool` | `true` | no |
| backup\_tags | A mapping of tags to assign to the backup resource. | `map` | `{}` | no |
| backup\_volumes\_cold\_storage\_after | Specifies the number of days after creation that a recovery point is moved to cold storage | `number` | `0` | no |
| backup\_volumes\_completion\_window | The amount of time AWS Backup attempts a backup before canceling the job and returning an error. | `number` | `360` | no |
| backup\_volumes\_delete\_after | Specifies the number of days after creation that a recovery point is deleted. | `number` | `30` | no |
| backup\_volumes\_schedule | A CRON expression specifying when AWS Backup initiates a backup job. | `string` | `"cron(0 1 * * ? *)"` | no |
| backup\_volumes\_start\_window | The amount of time in minutes before beginning a backup. | `number` | `120` | no |
| backup\_volumes\_target\_vault\_name | The name of a logical container where backups are stored. | `string` | `"Default"` | no |
| buildin\_ebs\_block\_device | EBS block devices build into the under laying AMI to be attach to the instance. Block device configurations only apply on resource creation. | `list(map(string))` | `[]` | no |
| cpu\_credits | T2/T3 Unlimited configuration. Can be `standard` and `unlimited`. | `string` | `"standard"` | no |
| disable\_api\_termination | n/a | `bool` | `true` | no |
| ebs\_block\_device | This is following the parameters of `ebs_block_device` from the `terraform-aws-modules/ec2-instance/aws` module.<br>Extra parameter:<br>- `backup_volume` boolean (Optional, default is false): set whether or not to backup the volume by setting.<br>- `device_name` string:  (Required) The name of the device to mount. | `list(map(string))` | `[]` | no |
| ebs\_kms\_key\_arn | n/a | `string` | `""` | no |
| ebs\_optimized | n/a | `bool` | `null` | no |
| hosted\_zone\_id | n/a | `string` | `""` | no |
| hosted\_zone\_name | n/a | `string` | `""` | no |
| iam\_instance\_profile | n/a | `string` | `""` | no |
| instance\_name | n/a | `string` | `"ec2-instance"` | no |
| instance\_tags | A mapping of tags to assign to the EC2 instance resource. | `map` | `{}` | no |
| instance\_type | n/a | `string` | `"c4.large"` | no |
| key\_name | n/a | `string` | `""` | no |
| private\_ip | n/a | `string` | `""` | no |
| project\_namespace | n/a | `string` | `"terraform-aws-ec2-instance"` | no |
| project\_stage | n/a | `string` | `"dev"` | no |
| root\_block\_device\_delete\_on\_termination | n/a | `bool` | `true` | no |
| root\_block\_device\_iops | n/a | `number` | `null` | no |
| root\_block\_device\_size | n/a | `number` | `20` | no |
| route53\_record | n/a | `string` | `""` | no |
| subnet\_id | n/a | `string` | `""` | no |
| user\_data | n/a | `string` | `""` | no |
| volume\_tags | A mapping of tags to assign to the EBS volumes. | `map` | `{}` | no |
| vpc\_security\_group\_ids | n/a | `list` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | List of ARNs of instances |
| availability\_zone | List of availability zones of instances |
| backup\_plan\_arn | The ARN of the backup plan |
| backup\_plan\_id | The id of the backup plan |
| backup\_plan\_version | Unique, randomly generated, Unicode, UTF-8 encoded string that serves as the version ID of the backup plan |
| backup\_tags | n/a |
| backup\_vault\_arn | The ARN of the vault |
| backup\_vault\_id | The name of the vault |
| ebs\_block\_device\_volume\_ids | List of volume IDs of EBS block devices of instances |
| eip | n/a |
| fqdn | n/a |
| id | List of IDs of instances |
| instance\_state | List of instance states of instances |
| instance\_tags | n/a |
| ipv6\_addresses | List of assigned IPv6 addresses of instances |
| password\_data | List of Base-64 encoded encrypted password data for the instance |
| primary\_network\_interface\_id | List of IDs of the primary network interface of instances |
| private\_dns | List of private DNS names assigned to the instances. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC |
| private\_ip | List of private IP addresses assigned to the instances |
| public\_dns | List of public DNS names assigned to the instances. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC |
| public\_ip | List of public IP addresses assigned to the instances, if applicable |
| root\_block\_device\_volume\_ids | List of volume IDs of root block devices of instances |
| volume\_tags | n/a |

<!--- END_TF_DOCS --->
