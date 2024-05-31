variable "name_prefix" {
  type        = string
  description = "Prefix that will be prepended to resource names"
}

variable "service_arn" {
  type        = string
  description = "Elastic Container Service (ECS) Service ARN"
}

variable "users" {
  type        = set(string)
  description = "Set of user names"
}
