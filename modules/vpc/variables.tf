variable "cidr" {
  type        = string
  description = "CIDR Block"
}

variable "name" {
  type        = string
  description = "VPC name"
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