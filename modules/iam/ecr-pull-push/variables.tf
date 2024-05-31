variable "name_prefix" {
  type        = string
  description = "Prefix that will be prepended to resource names"
}

variable "ecr_arn" {
  type        = string
  description = "Elastic Container Registry Repository (ECR) ARN"
}

variable "pull_users" {
  type        = set(string)
  description = "Set of user names"
  default     = []
}

variable "push_users" {
  type        = set(string)
  description = "Set of user names"
  default     = []
}
