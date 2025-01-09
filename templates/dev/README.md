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

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_allow_secrets_access"></a> [allow\_secrets\_access](#module\_allow\_secrets\_access) | ../../modules/ssm/parameters-access | n/a |
| <a name="module_iam"></a> [iam](#module\_iam) | ../../modules/iam/user-with-access-key | n/a |
| <a name="module_iam_user"></a> [iam\_user](#module\_iam\_user) | ../../modules/iam/user-with-access-key | n/a |
| <a name="module_name_secrets"></a> [name\_secrets](#module\_name\_secrets) | Selleo/ssm/aws//modules/parameters | 0.3.0 |
| <a name="module_secrets"></a> [secrets](#module\_secrets) | Selleo/ssm/aws//modules/parameters | 0.4.0 |
| <a name="module_storage_s3_read_write"></a> [storage\_s3\_read\_write](#module\_storage\_s3\_read\_write) | ../../modules/iam/s3-read-write | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_group.emails](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group_policy_attachment.allow_emails_sending](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_s3_bucket.storage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_route53_zone.domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | Default AWS region | `string` | `"eu-central-1"` | no |
<!-- END_TF_DOCS -->