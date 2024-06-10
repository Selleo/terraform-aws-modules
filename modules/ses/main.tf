locals {
  dkim_verification_attrs = [for dkim in aws_ses_domain_dkim.this.dkim_tokens : {
    name  = "${dkim}._domainkey.${var.domain_name}"
    ttl   = 600
    type  = "CNAME"
    value = "${dkim}.dkim.amazonses.com"
  }]

  # remove empty options
  dmarc_record = join(";", compact([
    "v=${var.dmarc.v}",
    "p=${var.dmarc.p}",
    var.dmarc.pct == null ? null : "pct=${var.dmarc.pct}",
    var.dmarc.rua == null ? null : "rua=${var.dmarc.rua}",
    var.dmarc.ruf == null ? null : "ruf=${var.dmarc.ruf}",
    var.dmarc.fo == null ? null : "fo=${var.dmarc.fo}",
    var.dmarc.aspf == null ? null : "aspf=${var.dmarc.aspf}",
    var.dmarc.adkim == null ? null : "adkim=${var.dmarc.adkim}",
    var.dmarc.rf == null ? null : "rf=${var.dmarc.rf}",
    var.dmarc.ri == null ? null : "ri=${var.dmarc.ri}",
    var.dmarc.sp == null ? null : "sp=${var.dmarc.sp}",
  ]))
}

resource "aws_ses_email_identity" "this" {
  for_each = var.email_addresses
  email    = each.key
}

resource "aws_ses_domain_identity" "this" {
  domain = var.domain_name
}

resource "aws_ses_domain_dkim" "this" {
  domain = aws_ses_domain_identity.this.domain
}

data "aws_iam_policy_document" "this" {
  statement {
    actions = [
      "ses:SendEmail",
      "ses:SendRawEmail",
    ]

    resources = flatten(
      [[for email in aws_ses_email_identity.this : email.arn], aws_ses_domain_identity.this.arn],
    )
  }
}

resource "aws_iam_policy" "this" {
  name   = "${var.name_prefix}-ses-send-email"
  policy = data.aws_iam_policy_document.this.json
}


resource "aws_route53_record" "this_verify_dkim" {
  count = var.zone_id != "" && var.verify_dkim ? 3 : 0

  zone_id = var.zone_id
  name    = local.dkim_verification_attrs[count.index].name
  type    = local.dkim_verification_attrs[count.index].type
  ttl     = local.dkim_verification_attrs[count.index].ttl
  records = [local.dkim_verification_attrs[count.index].value]
}

resource "aws_route53_record" "ses_dmarc" {
  count = var.zone_id != "" && var.dmarc_enabled ? 1 : 0

  zone_id = var.zone_id
  name    = "_dmarc.${var.domain_name}"
  type    = "TXT"
  ttl     = 600
  records = [local.dmarc_record]
}

resource "aws_route53_record" "ses_spf" {
  count = var.zone_id != "" && var.spf_enabled ? 1 : 0

  zone_id = var.zone_id
  name    = var.domain_name
  type    = "TXT"
  ttl     = 600
  records = [
    "v=spf1 include:amazonses.com -all"
  ]
}
