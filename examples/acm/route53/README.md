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
| <a name="module_cert"></a> [cert](#module\_cert) | ../../../modules/acm-wildcard | n/a |
| <a name="module_info"></a> [info](#module\_info) | Selleo/context/null | 0.3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_route53_zone.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
<!-- END_TF_DOCS -->