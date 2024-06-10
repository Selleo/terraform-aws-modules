<!-- BEGIN_TF_DOCS -->


## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.71.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_route53_record.ses_dmarc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.ses_spf](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.this_verify_dkim](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_ses_domain_dkim.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_dkim) | resource |
| [aws_ses_domain_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_identity) | resource |
| [aws_ses_email_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_email_identity) | resource |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dmarc"></a> [dmarc](#input\_dmarc) | DMARC record for domain. Read full spec: https://mxtoolbox.com/dmarc/details/what-is-a-dmarc-record<br>  v     : required, protocol version (v=DMARC1)<br>  p     : required, policy (p=none\|quarantine\|reject)<br>  pct   : optional, percentage of messages subjected to filtering (0-100)<br>  rua   : optional, reporting URI for aggregate reports (mailto:aaa@domain.tld,mailto:bbb@domain.tld)<br>  ruf   : optional, reporting URI for forensic reports (mailto:aaa@domain.tld,mailto:bbb@domain.tld)<br>  fo    : optional, failure reporting options (fo=0\|1\|d\|s)<br>  aspf  : optional, The aspf tag represents alignment mode for SPF. An optional tag, aspf=r is a common example of its configuration.<br>  adkim : optional, The adkim tag represents alignment mode for DKIM. An optional tag, adkim=r is a common example of its configuration.<br>  rf    : optional, The rf tag represents reporting format. An optional tag, rf=afrf is a common example of its configuration.<br>  ri    : optional, The ri tag represents reporting interval. An optional tag, ri=86400 is a common example of its configuration.<br>  sp    : optional, The sp tag represents subdomain policy. An optional tag, sp=reject is a common example of its configuration. | <pre>object({<br>    v     = string # required, protocol version (v=DMARC1)<br>    p     = string # required, policy (p=none|quarantine|reject)<br>    pct   = number # optional, percentage of messages subjected to filtering (0-100)<br>    rua   = string # optional, reporting URI for aggregate reports (mailto:aaa@domain.tld,mailto:bbb@domain.tld)<br>    ruf   = string # optional, reporting URI for forensic reports (mailto:aaa@domain.tld,mailto:bbb@domain.tld)<br>    fo    = string # optional, failure reporting options (fo=0|1|d|s)<br>    aspf  = string # optional, The aspf tag represents alignment mode for SPF. An optional tag, aspf=r is a common example of its configuration.<br>    adkim = string # optional, The adkim tag represents alignment mode for DKIM. An optional tag, adkim=r is a common example of its configuration.<br>    rf    = string # optional, The rf tag represents reporting format. An optional tag, rf=afrf is a common example of its configuration.<br>    ri    = string # optional, The ri tag represents reporting interval. An optional tag, ri=86400 is a common example of its configuration.<br>    sp    = string # optional, The sp tag represents subdomain policy. An optional tag, sp=reject is a common example of its configuration.<br>  })</pre> | <pre>{<br>  "adkim": "s",<br>  "aspf": "s",<br>  "fo": null,<br>  "p": "reject",<br>  "pct": "100",<br>  "rf": null,<br>  "ri": null,<br>  "rua": null,<br>  "ruf": null,<br>  "sp": null,<br>  "v": "DMARC1"<br>}</pre> | no |
| <a name="input_dmarc_enabled"></a> [dmarc\_enabled](#input\_dmarc\_enabled) | Set DMARC record in Route53. | `bool` | `false` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The domain name from which AWS SES will be able to send emails. | `string` | n/a | yes |
| <a name="input_email_addresses"></a> [email\_addresses](#input\_email\_addresses) | Emails from which AWS SES will be able to send emails. | `set(string)` | `[]` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix that will be prepended to resource names | `string` | n/a | yes |
| <a name="input_spf_enabled"></a> [spf\_enabled](#input\_spf\_enabled) | Set SPF record in Route53. | `bool` | `false` | no |
| <a name="input_verify_dkim"></a> [verify\_dkim](#input\_verify\_dkim) | Automatically verify DKIM records in Route53. | `bool` | `false` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | The Route53 zone ID for the domain name. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dkim_verification_attrs"></a> [dkim\_verification\_attrs](#output\_dkim\_verification\_attrs) | DKIM name, value, type attributes needed to verify domain |
| <a name="output_send_email_policy_arn"></a> [send\_email\_policy\_arn](#output\_send\_email\_policy\_arn) | IAM policy ARN for sending emails |
<!-- END_TF_DOCS -->