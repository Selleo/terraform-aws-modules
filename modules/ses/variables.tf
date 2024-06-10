variable "name_prefix" {
  type        = string
  description = "Prefix that will be prepended to resource names"
}

variable "domain_name" {
  type        = string
  description = "The domain name from which AWS SES will be able to send emails."
}

# optional

variable "email_addresses" {
  type        = set(string)
  default     = []
  description = "Emails from which AWS SES will be able to send emails."
}

variable "zone_id" {
  type        = string
  description = "The Route53 zone ID for the domain name."
  default     = ""
}

variable "verify_dkim" {
  type        = bool
  description = "Automatically verify DKIM records in Route53."
  default     = false
}

variable "dmarc_enabled" {
  type        = bool
  description = "Set DMARC record in Route53."
  default     = false
}

variable "spf_enabled" {
  type        = bool
  description = "Set SPF record in Route53."
  default     = false
}

variable "dmarc" {
  description = <<EOT
  DMARC record for domain. Read full spec: https://mxtoolbox.com/dmarc/details/what-is-a-dmarc-record
  v     : required, protocol version (v=DMARC1)
  p     : required, policy (p=none|quarantine|reject)
  pct   : optional, percentage of messages subjected to filtering (0-100)
  rua   : optional, reporting URI for aggregate reports (mailto:aaa@domain.tld,mailto:bbb@domain.tld)
  ruf   : optional, reporting URI for forensic reports (mailto:aaa@domain.tld,mailto:bbb@domain.tld)
  fo    : optional, failure reporting options (fo=0|1|d|s)
  aspf  : optional, The aspf tag represents alignment mode for SPF. An optional tag, aspf=r is a common example of its configuration.
  adkim : optional, The adkim tag represents alignment mode for DKIM. An optional tag, adkim=r is a common example of its configuration.
  rf    : optional, The rf tag represents reporting format. An optional tag, rf=afrf is a common example of its configuration.
  ri    : optional, The ri tag represents reporting interval. An optional tag, ri=86400 is a common example of its configuration.
  sp    : optional, The sp tag represents subdomain policy. An optional tag, sp=reject is a common example of its configuration.
  EOT
  type = object({
    v     = string # required, protocol version (v=DMARC1)
    p     = string # required, policy (p=none|quarantine|reject)
    pct   = number # optional, percentage of messages subjected to filtering (0-100)
    rua   = string # optional, reporting URI for aggregate reports (mailto:aaa@domain.tld,mailto:bbb@domain.tld)
    ruf   = string # optional, reporting URI for forensic reports (mailto:aaa@domain.tld,mailto:bbb@domain.tld)
    fo    = string # optional, failure reporting options (fo=0|1|d|s)
    aspf  = string # optional, The aspf tag represents alignment mode for SPF. An optional tag, aspf=r is a common example of its configuration.
    adkim = string # optional, The adkim tag represents alignment mode for DKIM. An optional tag, adkim=r is a common example of its configuration.
    rf    = string # optional, The rf tag represents reporting format. An optional tag, rf=afrf is a common example of its configuration.
    ri    = string # optional, The ri tag represents reporting interval. An optional tag, ri=86400 is a common example of its configuration.
    sp    = string # optional, The sp tag represents subdomain policy. An optional tag, sp=reject is a common example of its configuration.
  })
  default = {
    v     = "DMARC1"
    p     = "reject"
    pct   = "100"
    rua   = null
    ruf   = null
    fo    = null
    aspf  = "s"
    adkim = "s"
    rf    = null
    ri    = null
    sp    = null
  }
}
