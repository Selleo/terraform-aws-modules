data "aws_route53_zone" "domain" {
  name = "your-domain.com" # TODO adjust name to your project
}

module "cloudfront_dns" {
    source = "../../modules/route53/cloudfront-record"

    name            = ""
    zone_id         = data.aws_route53_zone.example_com.zone_id # TODO adjust name to your project
    distribution_id = module.cloudfront_app.id
}

module "service" {
  source  = "../../modules/route53/load-balancer-record"

  lb_arn  = module.lb.id
  name    = "service"
  zone_id = data.aws_route53_zone.example_com.zone_id # TODO adjust name to your project
}