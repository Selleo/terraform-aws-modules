# subnet

## Usage

## Output

<!-- BEGIN_TF_DOCS -->


## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_eip.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_nat_gateway.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.public_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [random_id.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_config"></a> [config](#input\_config) | Subnet configuration | <pre>map(object({<br>    az   = string<br>    cidr = string<br>    nat  = bool<br>  }))</pre> | n/a | yes |
| <a name="input_context"></a> [context](#input\_context) | Context | <pre>object({<br>    namespace = string<br>    stage     = string<br>    name      = string<br>  })</pre> | <pre>{<br>  "name": "default",<br>  "namespace": "default",<br>  "stage": "default"<br>}</pre> | no |
| <a name="input_internet_gateway_id"></a> [internet\_gateway\_id](#input\_internet\_gateway\_id) | Internet Gateway ID | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ids"></a> [ids](#output\_ids) | Subnet IDs sorted by key |
| <a name="output_nat_gateways"></a> [nat\_gateways](#output\_nat\_gateways) | NAT Gateway IDs by AZ |
| <a name="output_nat_ips"></a> [nat\_ips](#output\_nat\_ips) | NAT Elastic IPs by AZ |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | Subnet IDs by AZ |
<!-- END_TF_DOCS -->