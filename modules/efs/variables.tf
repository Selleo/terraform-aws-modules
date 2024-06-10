variable "context" {
  description = "Project context."

  type = object({
    namespace = string
    stage     = string
    name      = string
  })
}

variable "name" {
  description = "Volume name (creation_token)"
  type        = string
}

variable "vpc" {
  description = "VPC that storage is located"
  type = object({
    id          = string
    subnets     = list(string)
    cidr_blocks = list(string)
  })
}

# optional

variable "backup" {
  type        = bool
  description = "Toggle backup on/off"
  default     = false
}
