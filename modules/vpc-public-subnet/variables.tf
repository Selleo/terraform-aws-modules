variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "config" {
  type = map(object({
    az   = string
    cidr = string
    nat  = bool
  }))
  description = "Subnet configuration"
}

variable "internet_gateway_id" {
  type        = string
  description = "Internet Gateway ID"
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