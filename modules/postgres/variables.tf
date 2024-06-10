variable "context" {
  description = "Project context."

  type = object({
    namespace = string
    stage     = string
    name      = string
  })
}

variable "vpc" {
  description = "VPC configuration (id, CIDR that has access to RDS and subnet)."

  type = object({
    id           = string
    cidr         = string
    subnet_group = string
  })
}

variable "identifier" {
  description = "RDS identifier."
  type        = string
}

variable "db_name" {
  description = "Database name."
  type        = string
}

variable "db_user" {
  description = "Database user."
  type        = string
}

# optional

variable "allow_major_version_upgrade" {
  description = "Allow major version upgrade"
  type        = bool
  default     = false
}

variable "multi_az" {
  description = "Enable multi AZ"
  type        = bool
  default     = true
}

variable "maintenance_window" {
  description = "Maintenance window"
  type        = string
  default     = "Mon:00:00-Mon:02:00"
}

variable "backup_window" {
  description = "Backup window"
  type        = string
  default     = "02:30-03:30"
}

variable "backup_retention_period" {
  description = "Backup retention period"

  type    = number
  default = 30
}

variable "apply_immediately" {
  description = "Apply changes immediately"
  type        = bool
  default     = false
}

variable "publicly_accessible" {
  description = "DB publicly accessible"
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "Deletion protection"
  type        = bool
  default     = true
}

variable "parameter_group_family" {
  description = "Parameter group family."
  type        = string
}

variable "engine_version" {
  description = "Postgres version."
  type        = string
}

variable "allocated_storage" {
  description = "Allocated storage size (GiB)"

  type    = number
  default = 20
}

variable "max_allocated_storage" {
  description = "Max allocated storage size (GiB)"

  type    = number
  default = 100
}

variable "password_length" {
  description = "Password length for random generator."

  type    = number
  default = 16
}

variable "logs_retention_in_days" {
  description = "Postgres and upgrade logs retention counted in days."

  type    = number
  default = 60
}

variable "port" {
  description = "Database port"

  type    = number
  default = 5432
}

variable "instance_class" {
  description = "Instance class."

  type    = string
  default = "db.t4g.micro"
}

variable "performance_insights" {
  description = "Performance insights configuration. Retention period valid values are 7, 731 (2 years) or a multiple of 31."

  type = object({
    retention_period = number
    kms_key_id       = string
  })
  default = {
    retention_period = 62
    kms_key_id       = null
  }
}

variable "snapshot_identifier" {
  description = "Snapshot identifier to restore from."
  type        = string
  default     = null
}

variable "parameters" {
  type        = map(string)
  description = "Configuration for parameters group"
  default     = {}
}
