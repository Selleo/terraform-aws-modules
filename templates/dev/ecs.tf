resource "random_id" "example" {
  byte_length = 2

  prefix = "discovery-"
}

# cluster

module "cluster" {
  source = "../modules/ecs-cluster"

  context = {
    namespace = "name" # TODO adjust name to your project
    stage     = "dev"
    name      = "cluster"
  }

  name_prefix          = random_id.example.hex
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
  source = "../modules/ecs-service"

  name          = random_id.example.hex
  vpc_id        = module.vpc.id
  subnet_ids    = module.public_subnet.ids
  cluster_id    = module.cluster.id
  desired_count = 1

  tcp_ports = [{
      name      = "http"
      host      = 0
      container = 3000
    }]

  context = {
    namespace = "name" # TODO adjust name to your project
    stage     = "dev"
    name      = "ecs"
  }
}
