locals {
  domain_name = "exmaple.com"
}

module "ses" {
  source          = "../../modules/ses"
  domain_name     = local.domain_name
  name_prefix     = "exmpale-com"

  zone_id     = data.aws_route53_zone.this.zone_id
  verify_dkim = true
}

resource "aws_iam_user" "this" {
  name = "example-com"
}

resource "aws_iam_access_key" "this" {
  user = aws_iam_user.this.name
}

resource "aws_iam_user_policy_attachment" "this" {
  user       = aws_iam_user.this.name
  policy_arn = module.ses.send_email_policy_arn
}

data "aws_route53_zone" "this" {
  name         = local.domain_name
  private_zone = false
}
