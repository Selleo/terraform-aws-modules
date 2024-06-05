variable "name" {
  type        = string
  description = "User name"
}

variable "groups" {
  type        = list(string)
  description = "List of groups to attach"
  default     = []
}

variable "policies" {
  type        = list(string)
  description = "List of policies to attach"
  default     = []
}
