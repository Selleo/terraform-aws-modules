variable "kms_arn" {
  type        = string
  description = "KMS key to encrypt session"
}

variable "ssm_document_arn" {
  type        = string
  description = "SSM document ARN to use by session"
}

# optional

variable "ssm_tag_key" {
  type        = string
  description = "SSM tag key used for accessing EC2"
  default     = "SSMAccess"
}

variable "ssm_tag_value" {
  type        = string
  description = "SSM tag value used for accessing EC2"
  default     = "true"
}
