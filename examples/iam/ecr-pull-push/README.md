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
| <a name="module_aws_iam_ecr_policy"></a> [aws\_iam\_ecr\_policy](#module\_aws\_iam\_ecr\_policy) | ../../modules/ecr-pull-push | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ecr_repository.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_iam_access_key.pull](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_access_key.push](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_user.pull](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user.push](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecr_registry_id"></a> [ecr\_registry\_id](#output\_ecr\_registry\_id) | n/a |
| <a name="output_ecr_repository_url"></a> [ecr\_repository\_url](#output\_ecr\_repository\_url) | n/a |
| <a name="output_iam_pull_user_id"></a> [iam\_pull\_user\_id](#output\_iam\_pull\_user\_id) | n/a |
| <a name="output_iam_pull_user_secret"></a> [iam\_pull\_user\_secret](#output\_iam\_pull\_user\_secret) | n/a |
| <a name="output_iam_push_user_id"></a> [iam\_push\_user\_id](#output\_iam\_push\_user\_id) | n/a |
| <a name="output_iam_push_user_secret"></a> [iam\_push\_user\_secret](#output\_iam\_push\_user\_secret) | n/a |
<!-- END_TF_DOCS -->