<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.70.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_iam_ecs_policy"></a> [aws\_iam\_ecs\_policy](#module\_aws\_iam\_ecs\_policy) | ../../../modules/iam/ecs-deploy | n/a |
| <a name="module_ecs_cluster"></a> [ecs\_cluster](#module\_ecs\_cluster) | Selleo/backend/aws//modules/ecs-cluster | n/a |
| <a name="module_ecs_service"></a> [ecs\_service](#module\_ecs\_service) | Selleo/backend/aws//modules/ecs-service | n/a |
| <a name="module_lb"></a> [lb](#module\_lb) | Selleo/backend/aws//modules/load-balancer | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_alb_listener.http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_listener) | resource |
| [aws_iam_access_key.ecs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_user.ecs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecs_cluster_id"></a> [ecs\_cluster\_id](#output\_ecs\_cluster\_id) | n/a |
| <a name="output_iam_user_id"></a> [iam\_user\_id](#output\_iam\_user\_id) | n/a |
| <a name="output_iam_user_secret"></a> [iam\_user\_secret](#output\_iam\_user\_secret) | n/a |
<!-- END_TF_DOCS -->