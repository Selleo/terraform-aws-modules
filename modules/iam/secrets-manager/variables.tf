variable "name_prefix" {
  type        = string
  description = "Prefix that will be prepended to resource names"
}

variable "secrets" {
  type        = set(string)
  description = "Set of Secret Manager Secrets ARNs"
}

variable "read_users" {
  type        = set(string)
  description = "Set of users names"
  default     = []
}

variable "write_users" {
  type        = set(string)
  description = "Set of users names"
  default     = []
}
