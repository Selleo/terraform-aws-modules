output "subnets" {
  value = {
    for key, config in var.config :
    config.az => aws_subnet.this[key].id
  }
  description = "Subnet IDs by AZ"
}

output "nat_ips" {
  value = {
    for key, config in local.nat_enabled_azs :
    config.az => aws_eip.nat[key].id
  }
  description = "NAT Elastic IPs by AZ"
}

output "nat_gateways" {
  value = {
    for key, config in local.nat_enabled_azs :
    config.az => aws_nat_gateway.nat[key].id
  }
  description = "NAT Gateway IDs by AZ"
}

output "ids" {
  # ensure consistent ordering
  value       = [for key in sort(keys(var.config)) : aws_subnet.this[key].id]
  description = "Subnet IDs sorted by key"
}
