# vpc

## Usage

## Output

<!-- BEGIN_TF_DOCS -->


## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_internet_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr"></a> [cidr](#input\_cidr) | CIDR Block | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input\_context) | Context | <pre>object({<br>    namespace = string<br>    stage     = string<br>    name      = string<br>  })</pre> | <pre>{<br>  "name": "default",<br>  "namespace": "default",<br>  "stage": "default"<br>}</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | VPC name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cidr"></a> [cidr](#output\_cidr) | The ID of the VPC |
| <a name="output_id"></a> [id](#output\_id) | The ID of the VPC |
| <a name="output_internet_gateway_id"></a> [internet\_gateway\_id](#output\_internet\_gateway\_id) | The ID of the Internet Gateway |
<!-- END_TF_DOCS -->