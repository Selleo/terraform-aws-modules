variable "s3_bucket" {
  description = "Name of S3 bucket."
  type        = string
}

variable "cloudfront_arns" {
  description = "list of cloudfront arns."
  type        = list(string)
}