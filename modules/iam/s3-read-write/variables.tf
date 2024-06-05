variable "name_prefix" {
  type        = string
  description = "Prefix that will be prepended to resource names"
}

variable "bucket_arn" {
  type        = string
  description = "S3 Bucket ARN"
}

variable "users" {
  type        = set(string)
  description = "Set of users names"
}
