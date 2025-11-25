locals {
  context = {
    namespace = "name" # TODO adjust name to your project
    stage     = "production"
    name      = "networking"
  }
}

module "vpc" {
  source = "../../modules/vpc"

  name = "name" # TODO adjust name to your project
  cidr = "10.0.0.0/16"
}

module "public_subnet" {
  source = "../../modules/vpc-public-subnet"

  vpc_id              = module.vpc.id
  internet_gateway_id = module.vpc.internet_gateway_id
  config = {
    "a" = {
      az   = "eu-central-1a"
      cidr = "10.0.1.0/24"
      nat  = true
    }
    "b" = {
      az   = "eu-central-1b"
      cidr = "10.0.2.0/24"
      nat  = false
    }
  }
}

module "private_subnet" {
  source = "../../modules/vpc-private-subnet"

  context = local.context
  vpc_id  = module.vpc.id

  config = {
    "a" = {
      az   = "eu-central-1a"
      cidr = "10.0.51.0/24"
    }
  }
}

module "database_subnet" {
  source = "../../modules/vpc-private-subnet"

  context = local.context
  vpc_id  = module.vpc.id

  config = {
    "db-a" = {
      az   = "eu-central-1a"
      cidr = "10.0.101.0/24"
    }
  }

  database_subnet = true
}

module "lb" {
  source = "../../modules/lb/alb"

  name        = "name" #TODO adjust name to your project
  vpc_id      = module.vpc.id
  subnet_ids  = module.public_subnet.ids
  force_https = true

  context = local.context
}

resource "aws_alb_listener" "default" {
  load_balancer_arn = module.lb.id
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = module.cert.arn
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01" # https://docs.aws.amazon.com/elasticloadbalancing/latest/application/create-https-listener.html

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Hello there! Load balancer works."
      status_code  = "200"
    }
  }
}


resource "aws_lb_listener_rule" "service" {
  listener_arn = aws_alb_listener.default.arn
  priority     = 60

  action {
    type             = "forward"
    target_group_arn = module.service.lb_target_group_id # TODO adjust name to your project
  }

  condition {
    host_header {
      values = ["api.example.com"] # TODO adjust name to your project
    }
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}