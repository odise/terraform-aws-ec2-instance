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
| backup\_tags | n/a | `map` | `{}` | no |
| backup\_volumes | n/a | `bool` | `true` | no |
| backup\_volumes\_delete\_after | n/a | `number` | `30` | no |
| backup\_volumes\_schedule | n/a | `string` | `"cron(0 1 * * ? *)"` | no |
| buildin\_ebs\_block\_device | n/a | `list` | `[]` | no |
| cpu\_credits | T2/T3 Unlimited configuration. Can be `standard` and `unlimited`. | `string` | `"standard"` | no |
| disable\_api\_termination | n/a | `bool` | `true` | no |
| ebs\_block\_device | n/a | `list` | `[]` | no |
| ebs\_kms\_key\_arn | n/a | `string` | `""` | no |
| ebs\_optimized | n/a | `bool` | `null` | no |
| hosted\_zone\_id | n/a | `string` | `""` | no |
| hosted\_zone\_name | n/a | `string` | `""` | no |
| iam\_instance\_profile | n/a | `string` | `""` | no |
| instance\_name | n/a | `string` | `"ec2-instance"` | no |
| instance\_tags | n/a | `map` | `{}` | no |
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
| volume\_tags | n/a | `map` | `{}` | no |
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
