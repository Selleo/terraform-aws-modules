
variable "cloudfront_arns" {
  description = "list of cloudfront arns."
  type        = list(string)
}

variable "s3_origin_arns" {
  description = "List of S3 Origin ARNs."
  type        = list(string)
}

variable "s3_bucket_arn" {
  description = "S3 bucket ARN."
  type        = string
}
