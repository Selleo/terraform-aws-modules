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
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_distribution.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_origin_access_control.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_control) | resource |
| [random_id.prefix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [aws_s3_bucket.apps](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aliases"></a> [aliases](#input\_aliases) | List of CNAMEs | `list(string)` | n/a | yes |
| <a name="input_app_id"></a> [app\_id](#input\_app\_id) | Application ID and S3 folder | `string` | n/a | yes |
| <a name="input_apps_folder"></a> [apps\_folder](#input\_apps\_folder) | Folder where apps are stored, must end with /. | `string` | `"apps/"` | no |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | AWS ACM certificate ARN. | `string` | n/a | yes |
| <a name="input_certificate_minimum_protocol_version"></a> [certificate\_minimum\_protocol\_version](#input\_certificate\_minimum\_protocol\_version) | The minimum version of the SSL protocol that you want to use for HTTPS. | `string` | `"TLSv1.2_2019"` | no |
| <a name="input_context"></a> [context](#input\_context) | Project context. | <pre>object({<br>    namespace = string<br>    stage     = string<br>    name      = string<br>  })</pre> | n/a | yes |
| <a name="input_custom_error_responses"></a> [custom\_error\_responses](#input\_custom\_error\_responses) | List of custom error responses for distribution. | <pre>list(object({<br>    error_code            = number<br>    error_caching_min_ttl = number<br>    response_code         = number<br>    response_page_path    = string<br>  }))</pre> | `[]` | no |
| <a name="input_default_root_object"></a> [default\_root\_object](#input\_default\_root\_object) | The object that you want CDN to return when an user requests the root URL. | `string` | `"index.html"` | no |
| <a name="input_price_class"></a> [price\_class](#input\_price\_class) | Cloudfront distribution's price class. | `string` | `"PriceClass_100"` | no |
| <a name="input_s3_bucket"></a> [s3\_bucket](#input\_s3\_bucket) | S3 bucket for Cloudfront origin. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags attached to Cloudfront distribution. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | CDN distribution ARN. |
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name) | CDN distribution's domain name. |
| <a name="output_hosted_zone_id"></a> [hosted\_zone\_id](#output\_hosted\_zone\_id) | CDN Route 53 zone ID. |
| <a name="output_id"></a> [id](#output\_id) | CDN distribution ID. |
| <a name="output_s3_origin_arn"></a> [s3\_origin\_arn](#output\_s3\_origin\_arn) | S3 Origin ARN with origin path |
<!-- END_TF_DOCS -->