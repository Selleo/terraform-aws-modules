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
| <a name="module_ses"></a> [ses](#module\_ses) | ../../modules/ses | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_access_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_user.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment) | resource |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dkim_verification_attrs"></a> [dkim\_verification\_attrs](#output\_dkim\_verification\_attrs) | n/a |
| <a name="output_domain_identity_verification_attrs"></a> [domain\_identity\_verification\_attrs](#output\_domain\_identity\_verification\_attrs) | n/a |
| <a name="output_user_key_id"></a> [user\_key\_id](#output\_user\_key\_id) | n/a |
| <a name="output_user_secret"></a> [user\_secret](#output\_user\_secret) | n/a |
<!-- END_TF_DOCS -->