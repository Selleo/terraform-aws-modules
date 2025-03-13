# required

variable "context" {
  description = "Project context."

  type = object({
    namespace = string
    stage     = string
    name      = string
  })
}

variable "aliases" {
  type        = list(string)
  description = "List of CNAMEs"
}

variable "certificate_arn" {
  type        = string
  description = "AWS ACM certificate ARN."
}

variable "bucket" {
  type        = string
  description = "Bucket name to create."
}

# optional

variable "tags" {
  type        = map(string)
  description = "Tags attached to Cloudfront distribution."
  default     = {}
}

variable "certificate_minimum_protocol_version" {
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution#minimum_protocol_version
  type        = string
  default     = "TLSv1.2_2019"
  description = "The minimum version of the SSL protocol that you want to use for HTTPS."
}

variable "response_headers_policy_id" {
  type        = string
  description = "The identifier for a response headers policy."
  default     = null
}

variable "origin_request_policy_id" {
  type        = string
  description = "The identifier for a origin request policy."
  default     = null
}

variable "price_class" {
  type        = string
  description = "Cloudfront distribution's price class."
  default     = "PriceClass_100"
}
