locals {
  tags = merge({
    "context.namespace"   = var.context.namespace
    "context.stage"       = var.context.stage
    "context.name"        = var.context.name
  }, var.tags)
}

resource "aws_alb" "this" {
  name            = var.name
  subnets         = var.subnet_ids
  security_groups = [aws_security_group.lb_sg.id]
  idle_timeout    = 1800

  access_logs {
    bucket  = var.access_logs.bucket
    prefix  = var.access_logs.prefix
    enabled = var.access_logs.enabled
  }

  tags = merge(local.tags, { "resource.group" = "network" })
}

resource "aws_alb_listener" "this" {
  count = var.allow_http && var.force_https ? 1 : 0

  load_balancer_arn = resource.aws_alb.this.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
      query       = "#{query}"
    }
  }
}

resource "aws_security_group" "lb_sg" {
  description = "controls access to the application ELB"
  vpc_id      = var.vpc_id
  name        = "lb-${var.name}"

  tags = merge(local.tags, { "resource.group" = "network" })
}

resource "aws_security_group_rule" "http" {
  count = var.allow_http ? 1 : 0

  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = var.cidr_blocks
  ipv6_cidr_blocks  = var.ipv6_cidr_blocks
  security_group_id = aws_security_group.lb_sg.id
}

resource "aws_security_group_rule" "https" {
  count = var.allow_https ? 1 : 0

  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = var.cidr_blocks
  ipv6_cidr_blocks  = var.ipv6_cidr_blocks
  security_group_id = aws_security_group.lb_sg.id
}

resource "aws_security_group_rule" "allow_all_outbound_lb" {
  count = var.allow_all_outbound ? 1 : 0

  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.lb_sg.id
}
