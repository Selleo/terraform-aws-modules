<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_alb_target_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_target_group) | resource |
| [aws_cloudwatch_log_group.one_off](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_ecs_service.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.one_off](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_ecs_task_definition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_group.deployment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group_policy_attachment.pass_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_group_policy_attachment.run_one_off_task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_group_policy_attachment.update_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_policy.deployment_run_one_off_task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.pass_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.update_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.task_execution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.task_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.cloudwatch_one_off](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.ssm_get](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.task_execution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.task_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [random_id.prefix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloudwatch_one_off](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.pass_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.run_task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.task_execution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.task_execution_ssm_get](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.task_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.update_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_id"></a> [cluster\_id](#input\_cluster\_id) | ECS Cluster id. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input\_context) | Project context. | <pre>object({<br>    namespace = string<br>    stage     = string<br>    name      = string<br>  })</pre> | n/a | yes |
| <a name="input_create_alb_target_group"></a> [create\_alb\_target\_group](#input\_create\_alb\_target\_group) | Register service as targer for load balancer. | `bool` | `true` | no |
| <a name="input_deployment_maximum_percent"></a> [deployment\_maximum\_percent](#input\_deployment\_maximum\_percent) | Upper limit (as a percentage of the service's `desired_count`) of the number of running tasks that can be running in a service during a deployment. Not valid when using the `DAEMON` scheduling strategy. | `number` | `200` | no |
| <a name="input_deployment_minimum_healthy_percent"></a> [deployment\_minimum\_healthy\_percent](#input\_deployment\_minimum\_healthy\_percent) | Lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment. | `number` | `50` | no |
| <a name="input_deregistration_delay"></a> [deregistration\_delay](#input\_deregistration\_delay) | Deregistration delay (draining time) from LB. | `number` | `30` | no |
| <a name="input_desired_count"></a> [desired\_count](#input\_desired\_count) | Desired task count. | `number` | n/a | yes |
| <a name="input_efs"></a> [efs](#input\_efs) | EFS volume to mount to ECS | <pre>object({<br>    id         = string<br>    mount_path = string<br>    volume     = string<br>  })</pre> | `null` | no |
| <a name="input_enable_execute_command"></a> [enable\_execute\_command](#input\_enable\_execute\_command) | Allow to exec into containers. | `bool` | `true` | no |
| <a name="input_health_check"></a> [health\_check](#input\_health\_check) | Health check config for ALB target group. | <pre>object({<br>    path    = string<br>    matcher = string<br>  })</pre> | <pre>{<br>  "matcher": "200",<br>  "path": "/"<br>}</pre> | no |
| <a name="input_health_check_threshold"></a> [health\_check\_threshold](#input\_health\_check\_threshold) | Health check thresholds for ALB target group. | <pre>object({<br>    timeout   = number<br>    interval  = number<br>    healthy   = number<br>    unhealthy = number<br>  })</pre> | <pre>{<br>  "healthy": 3,<br>  "interval": 15,<br>  "timeout": 10,<br>  "unhealthy": 3<br>}</pre> | no |
| <a name="input_log_retention_in_days"></a> [log\_retention\_in\_days](#input\_log\_retention\_in\_days) | Log retention in days for Cloudwatch. | `string` | `60` | no |
| <a name="input_name"></a> [name](#input\_name) | ECS Service name. | `string` | n/a | yes |
| <a name="input_one_off_commands"></a> [one\_off\_commands](#input\_one\_off\_commands) | Set of commands that the tasks are created for. | `set(string)` | `[]` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | Paths to secret. All secrets are read under the path. | `set(string)` | `[]` | no |
| <a name="input_service_discovery"></a> [service\_discovery](#input\_service\_discovery) | Service discovery configuration. | <pre>object({<br>    arn  = string<br>    name = string<br>  })</pre> | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of AWS subent IDs for service. | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags attached to resources. | `map(string)` | `{}` | no |
| <a name="input_tcp_ports"></a> [tcp\_ports](#input\_tcp\_ports) | Port mapping. Use 0 for dynamic host mapping. Fargate requires ports to be the same. | <pre>list(<br>    object({<br>      name      = string<br>      host      = number<br>      container = number<br>    })<br>  )</pre> | `[]` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC id. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_deployment_group"></a> [deployment\_group](#output\_deployment\_group) | Deployment group name |
| <a name="output_deployment_group_arn"></a> [deployment\_group\_arn](#output\_deployment\_group\_arn) | Deployment group ARN |
| <a name="output_lb_target_group_id"></a> [lb\_target\_group\_id](#output\_lb\_target\_group\_id) | ARN of the Target Group. |
| <a name="output_name"></a> [name](#output\_name) | Service name. |
| <a name="output_service_id"></a> [service\_id](#output\_service\_id) | ARN that identifies the service. |
| <a name="output_task_execution_role_id"></a> [task\_execution\_role\_id](#output\_task\_execution\_role\_id) | ECS task execution role ID |
| <a name="output_task_role_id"></a> [task\_role\_id](#output\_task\_role\_id) | ECS task role ID |
<!-- END_TF_DOCS -->