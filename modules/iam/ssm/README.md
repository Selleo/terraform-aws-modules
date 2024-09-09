<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_kms_arn"></a> [kms\_arn](#input\_kms\_arn) | KMS key to encrypt session | `string` | n/a | yes |
| <a name="input_ssm_document_arn"></a> [ssm\_document\_arn](#input\_ssm\_document\_arn) | SSM document ARN to use by session | `string` | n/a | yes |
| <a name="input_ssm_tag_key"></a> [ssm\_tag\_key](#input\_ssm\_tag\_key) | SSM tag key used for accessing EC2 | `string` | `"SSMAccess"` | no |
| <a name="input_ssm_tag_value"></a> [ssm\_tag\_value](#input\_ssm\_tag\_value) | SSM tag value used for accessing EC2 | `string` | `"true"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ssm_access_policy_rendered"></a> [ssm\_access\_policy\_rendered](#output\_ssm\_access\_policy\_rendered) | SSM policy to attach to IAM user/role that allows access EC2 |
| <a name="output_ssm_policy_rendered"></a> [ssm\_policy\_rendered](#output\_ssm\_policy\_rendered) | SSM policy to attach to EC2 role |
<!-- END_TF_DOCS -->