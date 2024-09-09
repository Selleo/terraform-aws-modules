<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.64.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_s3_full_access_policy"></a> [s3\_full\_access\_policy](#module\_s3\_full\_access\_policy) | ../../../modules/iam/s3-read-write | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_access_key.s3_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_user.s3_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_s3_bucket.example_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_user_id"></a> [iam\_user\_id](#output\_iam\_user\_id) | n/a |
| <a name="output_iam_user_secret"></a> [iam\_user\_secret](#output\_iam\_user\_secret) | n/a |
<!-- END_TF_DOCS -->