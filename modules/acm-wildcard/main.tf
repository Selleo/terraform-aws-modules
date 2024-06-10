locals {
  default_san = ["*.${var.domain}"]
  dvo_records = {
    for dvo in aws_acm_certificate.this.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  validation_records = var.validate ? local.dvo_records : {}

  tags = merge(module.info.tags, {
    "terraform.module"    = "Selleo/terraform-aws-acm"
    "terraform.submodule" = "wildcard"
  })
}

data "aws_route53_zone" "this" {
  count = var.validate ? 1 : 0

  name = var.validation_zone == "" ? var.domain : var.validation_zone
}


module "info" {
  source  = "Selleo/context/null"
  version = "0.3.0"

  namespace = var.context.namespace
  stage     = var.context.stage
  name      = var.context.name
}

resource "aws_acm_certificate" "this" {
  domain_name               = var.domain
  subject_alternative_names = var.wildcard ? local.default_san : var.san
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = local.tags
}

resource "aws_route53_record" "validation" {
  for_each = local.validation_records

  allow_overwrite = var.allow_overwrite
  name            = each.value.name
  records         = [each.value.record]
  ttl             = var.ttl
  type            = each.value.type
  zone_id         = data.aws_route53_zone.this[0].zone_id
}
