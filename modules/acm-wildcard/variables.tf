variable "context" {
  description = "Project context."

  type = object({
    namespace = string
    stage     = string
    name      = string
  })
}

variable "domain" {
  description = "Domain for the certificate"
  type        = string
}

# optional

variable "validate" {
  description = <<-EOS
    Auto adds CNAME entries for validation in Route53.
    When external DNS provider is used this must be set to `false`.
  EOS

  type    = bool
  default = true
}

variable "san" {
  description = "Subject alternative names (conflicts with: `wildcard`)."
  type        = list(string)
  default     = []
}

variable "wildcard" {
  description = "Generates wildcard certificate (conflicts with: `san`)."
  type        = bool
  default     = true
}

variable "ttl" {
  description = "Default TTL for Route53 record validation."
  type        = number
  default     = 60
}

variable "allow_overwrite" {
  description = "Allow to overwrite Route53 records."
  type        = bool
  default     = true
}

variable "validation_zone" {
  description = "Zone used for validation. If empty defaults to domain."
  type        = string
  default     = ""
}
