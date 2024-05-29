# subnet

## Usage

## Output

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
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_db_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_route.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [random_id.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_config"></a> [config](#input\_config) | Subnet configuration | <pre>map(object({<br>    az   = string<br>    cidr = string<br>  }))</pre> | n/a | yes |
| <a name="input_context"></a> [context](#input\_context) | Context | <pre>object({<br>    namespace = string<br>    stage     = string<br>    name      = string<br>  })</pre> | <pre>{<br>  "name": "default",<br>  "namespace": "default",<br>  "stage": "default"<br>}</pre> | no |
| <a name="input_database_subnet"></a> [database\_subnet](#input\_database\_subnet) | Database subnet group | `bool` | `false` | no |
| <a name="input_nat_gateway_routing"></a> [nat\_gateway\_routing](#input\_nat\_gateway\_routing) | NAT Gateway routing | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database_subnet_group_id"></a> [database\_subnet\_group\_id](#output\_database\_subnet\_group\_id) | Database subnet group ID |
| <a name="output_ids"></a> [ids](#output\_ids) | Subnet IDs sorted by key |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | Subnet IDs by AZ |
<!-- END_TF_DOCS -->