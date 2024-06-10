module "info" {
  source  = "Selleo/context/null"
  version = "0.3.0"

  namespace = "kudos"
  stage     = "developemnt"
  name      = "api"
}

resource "aws_route53_zone" "example" {
  name = "route53.example.selleo.com"
}

module "cert" {
  source = "../../modules/acm-wildcard"

  domain   = aws_route53_zone.example.name
  context  = module.info.context
  wildcard = false

  depends_on = [aws_route53_zone.example]
}
