# cluster

module "cluster" {
  source = "../../modules/ecs-cluster"

  context = {
    namespace = "name" # TODO adjust name to your project
    stage     = "staging"
    name      = "cluster"
  }

  name_prefix          = "name" # TODO adjust name to your project
  vpc_id               = module.vpc.id
  subnet_ids           = module.public_subnet.ids
  instance_type        = "t3.small"
  lb_security_group_id = module.lb.security_group_id

  autoscaling_group = {
    min_size         = 1
    max_size         = 5
    desired_capacity = 1
  }
}

module "service" {
  source = "../../modules/ecs-service"

  name          = "name" # TODO adjust name to your project
  vpc_id        = module.vpc.id
  subnet_ids    = module.public_subnet.ids
  cluster_id    = module.cluster.id
  desired_count = 1

  secrets = ["/name/staging/service/terraform", "/name/staging/service/editable"]

  tcp_ports = [{
      name      = "http"
      host      = 0
      container = 3000
    }]

  context = {
    namespace = "name" # TODO adjust name to your project
    stage     = "staging"
    name      = "ecs"
  }
}

# TODO Optional variable to create SSM parameter for private key
# resource "aws_ssm_parameter" "private_key" {  
#   name        = "/ecs/config/PRIVATE_KEY_PEM"
#   description = "Private key for EC2 instance"
#   type        = "SecureString"
#   value       = module.cluster.private_key_pem
# }