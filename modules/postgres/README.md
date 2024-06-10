<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.this_postgresql](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.this_upgrade](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_db_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_parameter_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.ingress_with_cidr_blocks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [random_id.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_password.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | Allocated storage size (GiB) | `number` | `20` | no |
| <a name="input_allow_major_version_upgrade"></a> [allow\_major\_version\_upgrade](#input\_allow\_major\_version\_upgrade) | Allow major version upgrade | `bool` | `false` | no |
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | Apply changes immediately | `bool` | `false` | no |
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | Backup retention period | `number` | `30` | no |
| <a name="input_backup_window"></a> [backup\_window](#input\_backup\_window) | Backup window | `string` | `"02:30-03:30"` | no |
| <a name="input_context"></a> [context](#input\_context) | Project context. | <pre>object({<br>    namespace = string<br>    stage     = string<br>    name      = string<br>  })</pre> | n/a | yes |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | Database name. | `string` | n/a | yes |
| <a name="input_db_user"></a> [db\_user](#input\_db\_user) | Database user. | `string` | n/a | yes |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Deletion protection | `bool` | `true` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | Postgres version. | `string` | n/a | yes |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | RDS identifier. | `string` | n/a | yes |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | Instance class. | `string` | `"db.t4g.micro"` | no |
| <a name="input_logs_retention_in_days"></a> [logs\_retention\_in\_days](#input\_logs\_retention\_in\_days) | Postgres and upgrade logs retention counted in days. | `number` | `60` | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | Maintenance window | `string` | `"Mon:00:00-Mon:02:00"` | no |
| <a name="input_max_allocated_storage"></a> [max\_allocated\_storage](#input\_max\_allocated\_storage) | Max allocated storage size (GiB) | `number` | `100` | no |
| <a name="input_multi_az"></a> [multi\_az](#input\_multi\_az) | Enable multi AZ | `bool` | `true` | no |
| <a name="input_parameter_group_family"></a> [parameter\_group\_family](#input\_parameter\_group\_family) | Parameter group family. | `string` | n/a | yes |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | Configuration for parameters group | `map(string)` | `{}` | no |
| <a name="input_password_length"></a> [password\_length](#input\_password\_length) | Password length for random generator. | `number` | `16` | no |
| <a name="input_performance_insights"></a> [performance\_insights](#input\_performance\_insights) | Performance insights configuration. Retention period valid values are 7, 731 (2 years) or a multiple of 31. | <pre>object({<br>    retention_period = number<br>    kms_key_id       = string<br>  })</pre> | <pre>{<br>  "kms_key_id": null,<br>  "retention_period": 62<br>}</pre> | no |
| <a name="input_port"></a> [port](#input\_port) | Database port | `number` | `5432` | no |
| <a name="input_publicly_accessible"></a> [publicly\_accessible](#input\_publicly\_accessible) | DB publicly accessible | `bool` | `false` | no |
| <a name="input_snapshot_identifier"></a> [snapshot\_identifier](#input\_snapshot\_identifier) | Snapshot identifier to restore from. | `string` | `null` | no |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | VPC configuration (id, CIDR that has access to RDS and subnet). | <pre>object({<br>    id           = string<br>    cidr         = string<br>    subnet_group = string<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connection_envs"></a> [connection\_envs](#output\_connection\_envs) | PostgreSQL connection environment variables |
| <a name="output_host"></a> [host](#output\_host) | Database host (format: my-database-instance-identifier.xxxxxxxxxxxxx.us-east-1.rds.amazonaws.com |
| <a name="output_port"></a> [port](#output\_port) | Database port (format: 5432) |
| <a name="output_url"></a> [url](#output\_url) | Database URL (format: postgres://..:5432/...) |
<!-- END_TF_DOCS -->