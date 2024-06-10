output "url" {
  description = "Database URL (format: postgres://..:5432/...)"
  sensitive   = true

  value = local.db_url
}

output "host" {
  description = "Database host (format: my-database-instance-identifier.xxxxxxxxxxxxx.us-east-1.rds.amazonaws.com"

  value = local.db_host
}

output "port" {
  description = "Database port (format: 5432)"

  value = local.db_port
}

output "connection_envs" {
  description = "PostgreSQL connection environment variables"
  sensitive   = true

  value = {
    PGHOST     = local.db_host
    PGPORT     = local.db_port
    PGDATABASE = local.db_name
    PGUSER     = local.db_user
    PGPASSWORD = local.db_pass
  }
}
