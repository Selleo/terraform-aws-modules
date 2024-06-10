data "aws_cloudfront_distribution" "this" {
  id = var.distribution_id
}

resource "aws_route53_record" "this" {
  zone_id = var.zone_id
  name    = var.name
  type    = "A"

  alias {
    name                   = data.aws_cloudfront_distribution.this.domain_name
    zone_id                = data.aws_cloudfront_distribution.this.hosted_zone_id
    evaluate_target_health = var.evaluate_target_health
  }
}

