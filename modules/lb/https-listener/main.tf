resource "aws_alb_listener" "https" {
  load_balancer_arn = var.load_balancer_arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = var.certificate_arn
  ssl_policy        = var.ssl_policy

  default_action {
    target_group_arn = var.target_group_arn
    type             = "forward"
  }
}
