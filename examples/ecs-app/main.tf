locals {
  context = {
    namespace = "selleo"
    stage     = "dev"
    name      = "example"
  }
}

resource "random_id" "example" {
  byte_length = 2

  prefix = "discovery-"
}

# network

module "vpc" {
  source = "../../modules/vpc"

  name = random_id.example.hex
  cidr = "10.0.0.0/16"
}

module "public_subnets" {
  source = "../../modules/vpc-public-subnet"

  vpc_id              = module.vpc.id
  internet_gateway_id = module.vpc.internet_gateway_id
  config = {
    "a" = {
      az   = "eu-central-1a"
      cidr = "10.0.1.0/24"
      nat  = false
    }
    "b" = {
      az   = "eu-central-1b"
      cidr = "10.0.2.0/24"
      nat  = false
    }
  }
}

module "lb" {
  source = "../../modules/lb/alb"

  name        = random_id.example.hex
  vpc_id      = module.vpc.id
  subnet_ids  = module.public_subnets.ids
  force_https = false

  context = local.context
}

# cluster

module "cluster" {
  source = "../../modules/ecs-cluster"

  context = {
    namespace = "selleo"
    stage     = "dev"
    name      = "example"
  }

  name_prefix          = random_id.example.hex
  vpc_id               = module.vpc.id
  subnet_ids           = module.public_subnets.ids
  instance_type        = "t3.nano"
  lb_security_group_id = module.lb.security_group_id

  autoscaling_group = {
    min_size         = 1
    max_size         = 5
    desired_capacity = 1
  }
}

module "service" {
  source = "../../modules/ecs-service"

  name          = random_id.example.hex
  vpc_id        = module.vpc.id
  subnet_ids    = module.public_subnets.ids
  cluster_id    = module.cluster.id
  desired_count = 1

  tcp_ports = [{
      name      = "http"
      host      = 0
      container = 3000
    }]

  context = local.context
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = module.lb.id
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = module.service.lb_target_group_id
    type             = "forward"
  }
}

output "lb_dns" {
  value = "http://${module.lb.dns_name}"
}
