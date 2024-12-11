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
| <a name="module_allow_secrets_access"></a> [allow\_secrets\_access](#module\_allow\_secrets\_access) | Selleo/ssm/aws//modules/parameters-access | 0.4.0 |
| <a name="module_iam_user"></a> [iam\_user](#module\_iam\_user) | Selleo/iam/aws//modules/user-with-access-key | 0.7.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_group.emails](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group_policy_attachment.allow_emails_sending](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_route53_zone.domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | Default AWS region | `string` | `"eu-central-1"` | no |
<!-- END_TF_DOCS -->