module "ses" {
  source  = "../../modules/ses"

  name_prefix     = "name-staging" # TODO adjust name to your project
  domain_name     = "example.com"
  zone_id         = data.aws_route53_zone.example_com.id # TODO adjust name to your project
  verify_dkim     = true
  dmarc_enabled   = true
  spf_enabled     = true
  email_addresses = [
    "your.name@example.com" # TODO adjust name to your project
  ]
}
