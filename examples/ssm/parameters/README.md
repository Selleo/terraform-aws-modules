<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_secrets"></a> [secrets](#module\_secrets) | ../../../modules/ssm/parameters | n/a |
| <a name="module_secrets_access"></a> [secrets\_access](#module\_secrets\_access) | ../../../modules/ssm/parameters-access | n/a |

## Resources

| Name | Type |
|------|------|
| [random_id.secret_key_base](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_group"></a> [access\_group](#output\_access\_group) | n/a |
| <a name="output_editable_secrets"></a> [editable\_secrets](#output\_editable\_secrets) | n/a |
| <a name="output_secrets"></a> [secrets](#output\_secrets) | n/a |
<!-- END_TF_DOCS -->