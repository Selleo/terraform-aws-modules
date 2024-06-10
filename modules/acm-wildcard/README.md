<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_info"></a> [info](#module\_info) | Selleo/context/null | 0.3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_route53_record.validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_overwrite"></a> [allow\_overwrite](#input\_allow\_overwrite) | Allow to overwrite Route53 records. | `bool` | `true` | no |
| <a name="input_context"></a> [context](#input\_context) | Project context. | <pre>object({<br>    namespace = string<br>    stage     = string<br>    name      = string<br>  })</pre> | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | Domain for the certificate | `string` | n/a | yes |
| <a name="input_san"></a> [san](#input\_san) | Subject alternative names (conflicts with: `wildcard`). | `list(string)` | `[]` | no |
| <a name="input_ttl"></a> [ttl](#input\_ttl) | Default TTL for Route53 record validation. | `number` | `60` | no |
| <a name="input_validate"></a> [validate](#input\_validate) | Auto adds CNAME entries for validation in Route53.<br>When external DNS provider is used this must be set to `false`. | `bool` | `true` | no |
| <a name="input_validation_zone"></a> [validation\_zone](#input\_validation\_zone) | Zone used for validation. If empty defaults to domain. | `string` | `""` | no |
| <a name="input_wildcard"></a> [wildcard](#input\_wildcard) | Generates wildcard certificate (conflicts with: `san`). | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Certifcate ARN |
| <a name="output_validation_records"></a> [validation\_records](#output\_validation\_records) | Map of DNS records used for certificate validation. |
| <a name="output_zone_id"></a> [zone\_id](#output\_zone\_id) | Route53 zone ID |
<!-- END_TF_DOCS -->