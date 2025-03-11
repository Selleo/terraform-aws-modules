locals {
  context = {
    namespace = "selleo"
    stage     = "dev"
    name      = "example"
  }
}

# network

module "vpc" {
  source = "../../modules/vpc"

  name = "discovery"
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

  name        = "discovery"
  vpc_id      = module.vpc.id
  subnet_ids  = module.public_subnets.ids
  force_https = false

  context = local.context
}

resource "aws_service_discovery_http_namespace" "local" {
  name        = "local"
  description = "Service discovery namespace for ECS services"

  tags = {
    "context.namespace" = "selleo"
    "context.stage"     = "dev"
    "context.name"      = "app"
  }
}

# cluster

# module "cluster" {
#   source = "../../modules/ecs-cluster"

#   context = {
#     namespace = "selleo"
#     stage     = "dev"
#     name      = "example"
#   }

#   name_prefix          = random_id.example.hex
#   vpc_id               = module.vpc.id
#   subnet_ids           = module.public_subnets.ids
#   instance_type        = "t3.nano"
#   lb_security_group_id = module.lb.security_group_id

#   autoscaling_group = {
#     min_size         = 1
#     max_size         = 5
#     desired_capacity = 1
#   }
# }

module "static_cluster" {
  source = "../../modules/ecs-cluster-static"

  context = {
    namespace = "selleo"
    stage     = "dev"
    name      = "example"
  }
  name_prefix          = "static-cluster"
  vpc_id               = module.vpc.id
  subnet_ids           = module.public_subnets.ids
  instance_type        = "t3.nano"
  lb_security_group_id = module.lb.security_group_id

  instances = {
    "search1" = {
      ip        = "10.0.1.1"
      subnet_id = module.public_subnets.ids[0]
    }
  }
}

# module "service" {
#   source = "../../modules/ecs-service"

#   context = {
#     namespace = "selleo"
#     stage     = "dev"
#     name      = "example"
#   }

#   name          = random_id.example.hex
#   vpc_id        = module.vpc.id
#   subnet_ids    = module.public_subnets.ids
#   cluster_id    = module.cluster.id
#   desired_count = 1

#   tcp_ports = [
#     {
#       name      = "http"
#       host      = 0
#       container = 3000
#     }
#   ]

#   service_discovery = {
#     arn  = aws_service_discovery_http_namespace.local.arn
#     name = "app"
#   }
# }

module "secrets" {
  source = "../../modules/ssm/parameters"

  context = local.context

  path = "/example/meilisearch"
  secrets = {
    # See other config: https://www.meilisearch.com/docs/learn/self_hosted/configure_meilisearch_at_launch
    MEILI_NO_ANALYTICS = "1"
    MEILI_ENV          = "production"
    MEILI_DB_PATH      = "/meili/data"
    MEILI_MASTER_KEY   = "c4379222ecf8533c6004153a31294d30ca481813a9e43284c85a8e3aeb96da19" # ❗️ THIS SHOULD BE EDITABLE SECRET, NOT HARDCODED - this only for example
  }
}

module "static_service" {
  source = "../../modules/ecs-service-managed"

  context = local.context

  name          = "meilisearch"
  vpc_id        = module.vpc.id
  subnet_ids    = module.public_subnets.ids[0]
  cluster_id    = module.static_cluster.id
  desired_count = 1

  tcp_ports = [
    {
      name      = "http"
      host      = 0
      container = 7700
    }
  ]
  image = "getmeili/meilisearch:v1.13"
  limits = {
    mem_min = 100
    mem_max = 400
    cpu     = 500
  }
  # volumes = [
  #   {
  #     name = "$pwd/meili_data"
  #     path = "/meili_data"
  #   }
  # ]

  service_discovery = {
    arn  = aws_service_discovery_http_namespace.local.arn
    name = "meilisearch"
  }
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

# outputs

output "lb_dns" {
  value = "http://${module.lb.dns_name}"
}
