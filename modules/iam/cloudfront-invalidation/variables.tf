variable "name_prefix" {
  type        = string
  description = "Prefix that will be prepended to resource names"
}

variable "cloudfront_arns" {
  type        = list(string)
  description = "Cloudfront ARNs"
}

variable "users" {
  type        = set(string)
  description = "Set of users names"
}

