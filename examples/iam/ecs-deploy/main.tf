# ECS setup is taken from: https://github.com/Selleo/terraform-aws-backend/blob/main/examples/basic-ecs-setup/main.tf

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "test"
  cidr = "10.0.0.0/16"

  azs             = ["eu-central-1a", "eu-central-1b"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform   = "true"
    Environment = "test"
  }
}

module "lb" {
  source = "Selleo/backend/aws//modules/load-balancer"

  name       = "ecs-lb"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets

  tags = {
    Terraform   = "true"
    Environment = "test"
  }
}

module "ecs_cluster" {
  source = "Selleo/backend/aws//modules/ecs-cluster"

  name_prefix        = "test"
  region             = "eu-central-1"
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.public_subnets
  instance_type      = "t3.micro"
  security_groups    = []
  loadbalancer_sg_id = module.lb.loadbalancer_sg_id
  autoscaling_group = {
    min_size         = 1
    max_size         = 1
    desired_capacity = 1
  }
}

module "ecs_service" {
  source = "Selleo/backend/aws//modules/ecs-service"

  name           = "test"
  vpc_id         = module.vpc.vpc_id
  ecs_cluster_id = module.ecs_cluster.ecs_cluster_id
  desired_count  = 1
  instance_role  = module.ecs_cluster.instance_role
  container_definition = {
    cpu_units      = 256
    mem_units      = 256
    command        = ["bundle", "exec", "ruby", "main.rb"],
    image          = "qbart/hello-ruby-sinatra:latest",
    container_port = 4567
    envs = {
      "APP_ENV" = "production"
    }
  }
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = module.lb.loadbalancer_id
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = module.ecs_service.lb_target_group_id
    type             = "forward"
  }
}

output "ecs_cluster_id" {
  value = module.ecs_cluster.ecs_cluster_id
}

resource "aws_iam_user" "ecs" {
  name = "ecs"
}

resource "aws_iam_access_key" "ecs" {
  user = aws_iam_user.ecs.name
}

output "iam_user_id" {
  value = aws_iam_access_key.ecs.id
}

output "iam_user_secret" {
  value     = aws_iam_access_key.ecs.secret
  sensitive = true
}

module "aws_iam_ecs_policy" {
  source      = "../../modules/ecs-deploy"
  name_prefix = "aws-iam"
  service_arn = module.ecs_service.service_id
  users       = [aws_iam_user.ecs.name]
}
