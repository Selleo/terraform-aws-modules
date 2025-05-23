# cluster

module "cluster" {
  source = "../../modules/ecs-cluster"

  context = {
    namespace = "name" # TODO adjust name to your project
    stage     = "production"
    name      = "cluster"
  }

  name_prefix          = "name" # TODO adjust name to your project
  vpc_id               = module.vpc.id
  subnet_ids           = module.public_subnet.ids
  instance_type        = "t3.medium"
  lb_security_group_id = module.lb.security_group_id

  autoscaling_group = {
    min_size         = 2
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

  tcp_ports = [{
      name      = "http"
      host      = 0
      container = 3000
    }]

  context = {
    namespace = "name" # TODO adjust name to your project
    stage     = "production"
    name      = "ecs"
  }
}
