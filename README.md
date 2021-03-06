# terraform-aws-ec2-instance

This module deploys an EC2 instance along with EBS snapshotting via AWS Backup, Elastic IP and Route53 DNS record. It uses the following Terraform modules underneath:

* [terraform-aws-modules/ec2-instance/aws](https://github.com/terraform-aws-modules/terraform-aws-ec2-instance/)
* [lgallard/backup/aws](https://github.com/lgallard/terraform-aws-backup)

# Usage
<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.26 |
| aws | >= 2.54.0 |
| random | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.54.0 |
| random | ~> 3.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ami | ID of AMI to use for the instance. | `string` | n/a | yes |
| assign\_eip | Whether or not to associate an elastic IP with this instance. | `bool` | `false` | no |
| associate\_public\_ip\_address | If true, the EC2 instance will have associated public IP address. | `bool` | `false` | no |
| backup\_ami | Set to true to create an AMI backup. | `bool` | `false` | no |
| backup\_buildin\_volumes | Set this `true` to backup all EBS volumes that facilitate the under laying AMI. Consider to use `backup_ami` instead. | `bool` | `true` | no |
| backup\_tags | A mapping of tags to assign to the backup resource. | `map` | `{}` | no |
| backup\_volumes\_cold\_storage\_after | Specifies the number of days after creation that a recovery point is moved to cold storage | `number` | `0` | no |
| backup\_volumes\_completion\_window | The amount of time AWS Backup attempts a backup before canceling the job and returning an error. | `number` | `360` | no |
| backup\_volumes\_delete\_after | Specifies the number of days after creation that a recovery point is deleted. | `number` | `30` | no |
| backup\_volumes\_schedule | A CRON expression specifying when AWS Backup initiates a backup job. | `string` | `"cron(0 1 * * ? *)"` | no |
| backup\_volumes\_start\_window | The amount of time in minutes before beginning a backup. | `number` | `60` | no |
| backup\_volumes\_target\_vault\_name | The name of a logical container where backups are stored. | `string` | `"Default"` | no |
| buildin\_ebs\_block\_device | EBS block devices build into the under laying AMI to be attach to the instance. Block device configurations only apply on resource creation. | `list(map(string))` | `[]` | no |
| cpu\_credits | T2/T3 Unlimited configuration. Can be `standard` and `unlimited`. | `string` | `"standard"` | no |
| disable\_api\_termination | If true, enables EC2 Instance Termination Protection. | `bool` | `true` | no |
| ebs\_block\_device | This is following the parameters of `ebs_block_device` from the `terraform-aws-modules/ec2-instance/aws` module.<br>Extra parameter:<br>- `backup_volume` boolean (Optional, default is false): set whether or not to backup the volume by setting.<br>- `device_name` string:  (Required) The name of the device to mount. | `list(map(string))` | `[]` | no |
| ebs\_kms\_key\_arn | (Optional) Amazon Resource Name (ARN) of the KMS Key to use when encrypting the volume. Must be configured to perform drift detection. | `string` | `""` | no |
| ebs\_optimized | (Optional) If true, the launched EC2 instance will be EBS-optimized. If not set module `terraform-aws-modules/terraform-aws-ebs-optimized` will determine the value. | `bool` | `null` | no |
| hosted\_zone\_id | (Required if `route53_record` is set) The ID of the hosted zone to contain this record. | `string` | `""` | no |
| hosted\_zone\_name | (Required if `route53_record` is set) The name of the hosted zone to contain this record. | `string` | `""` | no |
| iam\_instance\_profile | The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile. | `string` | `""` | no |
| instance\_name | The name of the EC2 instance. | `string` | `"ec2-instance"` | no |
| instance\_tags | A mapping of tags to assign to the EC2 instance resource. | `map` | `{}` | no |
| instance\_type | The type of instance to start | `string` | `"t2.medium"` | no |
| key\_name | The SSH key name to use for the instance. | `string` | `""` | no |
| private\_ip | Private IP address to associate with the instance in a VPC. | `string` | `""` | no |
| project\_namespace | n/a | `string` | `"terraform-aws-ec2-instance"` | no |
| project\_stage | n/a | `string` | `"dev"` | no |
| root\_block\_device\_delete\_on\_termination | (Optional) Whether the volume should be destroyed on instance termination (Default: true). | `bool` | `true` | no |
| root\_block\_device\_iops | (Optional) The amount of provisioned IOPS. This is only valid for volume\_type of `io1`/`io2`, and must be specified if using that type. | `number` | `null` | no |
| root\_block\_device\_size | (Optional) The size of the volume in gigabytes (GiB). | `number` | `20` | no |
| root\_block\_device\_type | (Optional) The type of volume. Can be `standard`, `gp2`, `io1`, `io2`, `sc1`, or `st1`. (Default: `gp2`). | `string` | `"gp2"` | no |
| route53\_record | The name of the record. | `string` | `""` | no |
| subnet\_id | The VPC Subnet ID to launch in. | `string` | `""` | no |
| user\_data | The user data to provide when launching the instance. | `string` | `""` | no |
| volume\_tags | A mapping of tags to assign to the EBS volumes. | `map` | `{}` | no |
| vpc\_security\_group\_ids | A list of security group IDs to associate with | `list(string)` | `[]` | no |

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
