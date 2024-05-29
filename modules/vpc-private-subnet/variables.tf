variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "config" {
  type = map(object({
    az   = string
    cidr = string
  }))
  description = "Subnet configuration"
}

variable "nat_gateway_routing" {
  type        = map(string)
  description = "NAT Gateway routing"
  default     = {}
}

variable "context" {
  type = object({
    namespace = string
    stage     = string
    name      = string
  })
  description = "Context"
  default = {
    namespace = "default"
    stage     = "default"
    name      = "default"
  }
}

variable "database_subnet" {
  type        = bool
  description = "Database subnet group "
  default     = false
}
