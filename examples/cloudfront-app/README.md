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
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.47.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudfront_app"></a> [cloudfront\_app](#module\_cloudfront\_app) | ../../modules/cloudfront-app | n/a |
| <a name="module_cloudfront_bucket_policy"></a> [cloudfront\_bucket\_policy](#module\_cloudfront\_bucket\_policy) | ../../modules/cloudfront-s3-origin-bucket-policy | n/a |
| <a name="module_cloudfront_deployment_policy"></a> [cloudfront\_deployment\_policy](#module\_cloudfront\_deployment\_policy) | ../../modules/cloudfront-deployment-policy | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [random_id.example](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
<!-- END_TF_DOCS -->