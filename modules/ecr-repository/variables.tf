variable "context" {
  description = "Project context"

  type = object({
    namespace = string
    stage     = string
    name      = string
  })
}

# optional

variable "max_image_count" {
  description = "Keep only last X images that are prefixed with `v`"
  type        = number
  default     = 100
}

variable "expire_untagged_after" {
  description = "Expire untagged images after X days"
  type        = number
  default     = 14
}

variable "max_preview_image" {
  description = "Expire images tagged with 'preview-' when there are more than X"
  type        = number
  default     = 10
}
