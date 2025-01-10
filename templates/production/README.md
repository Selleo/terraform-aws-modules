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
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.68.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ci_iam"></a> [ci\_iam](#module\_ci\_iam) | ../../modules/iam/user-with-access-key | n/a |
| <a name="module_cloudfront_app"></a> [cloudfront\_app](#module\_cloudfront\_app) | ../../modules/cloudfront-app | n/a |
| <a name="module_cloudfront_bucket_policy"></a> [cloudfront\_bucket\_policy](#module\_cloudfront\_bucket\_policy) | ../../modules/cloudfront-s3-origin-bucket-policy | n/a |
| <a name="module_cloudfront_deployment_policy"></a> [cloudfront\_deployment\_policy](#module\_cloudfront\_deployment\_policy) | ../../modules/cloudfront-deployment-policy | n/a |
| <a name="module_cluster"></a> [cluster](#module\_cluster) | ../../modules/ecs-cluster | n/a |
| <a name="module_database_subnet"></a> [database\_subnet](#module\_database\_subnet) | ../../modules/vpc-private-subnet | n/a |
| <a name="module_db"></a> [db](#module\_db) | ../../modules/postgres | n/a |
| <a name="module_ecr"></a> [ecr](#module\_ecr) | ../../modules/ecr-repository | n/a |
| <a name="module_lb"></a> [lb](#module\_lb) | ../../modules/lb/alb | n/a |
| <a name="module_private_subnet"></a> [private\_subnet](#module\_private\_subnet) | ../../modules/vpc-private-subnet | n/a |
| <a name="module_public_subnet"></a> [public\_subnet](#module\_public\_subnet) | ../../modules/vpc-public-subnet | n/a |
| <a name="module_secrets_ci"></a> [secrets\_ci](#module\_secrets\_ci) | ../../modules/ssm/parameters | n/a |
| <a name="module_service"></a> [service](#module\_service) | ../../modules/ecs-service | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ../../modules/vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.ci_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_user_policy_attachment.ci_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment) | resource |
| [aws_s3_bucket.apps_storage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_public_access_block.apps_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.ci_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_route53_zone.domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | Default AWS region | `string` | `"todo"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_url"></a> [url](#output\_url) | n/a |
<!-- END_TF_DOCS -->