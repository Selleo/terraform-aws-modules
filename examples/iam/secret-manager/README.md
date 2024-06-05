<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.69.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 3.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_iam_secret_manager_policy"></a> [aws\_iam\_secret\_manager\_policy](#module\_aws\_iam\_secret\_manager\_policy) | ../../../modules/iam/secrets-manager | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_access_key.full_access_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_access_key.read_only_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_user.full_access_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user.read_only_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_secretsmanager_secret.secret_no_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret.secret_no_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.bin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_secretsmanager_secret_version.kv](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [tls_private_key.app](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_user1_id"></a> [iam\_user1\_id](#output\_iam\_user1\_id) | n/a |
| <a name="output_iam_user1_secret"></a> [iam\_user1\_secret](#output\_iam\_user1\_secret) | n/a |
| <a name="output_iam_user2_id"></a> [iam\_user2\_id](#output\_iam\_user2\_id) | n/a |
| <a name="output_iam_user2_secret"></a> [iam\_user2\_secret](#output\_iam\_user2\_secret) | n/a |
<!-- END_TF_DOCS -->