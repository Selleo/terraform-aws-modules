data "aws_lb" "this" {
  arn = var.lb_arn
}

resource "aws_route53_record" "this" {
  zone_id = var.zone_id
  name    = var.name
  type    = "A"

  alias {
    name                   = data.aws_lb.this.dns_name
    zone_id                = data.aws_lb.this.zone_id
    evaluate_target_health = var.evaluate_target_health
  }
}

