output "subnets" {
  value = {
    for key, config in var.config :
    config.az => aws_subnet.this[key].id
  }
  description = "Subnet IDs by AZ"
}

output "ids" {
  # ensure consistent ordering
  value       = [for key in sort(keys(var.config)) : aws_subnet.this[key].id]
  description = "Subnet IDs sorted by key"
}

output "database_subnet_group_id" {
  value       = try(aws_db_subnet_group.this["db"].id, null)
  description = "Database subnet group ID"
}
