locals {
  context = {
    namespace = "selleo"
    stage     = "test"
    name      = "networking"
  }
}

module "vpc" {
  source = "../../modules/vpc"

  name = "test"
  cidr = "10.0.0.0/16"

  context = local.context
}

module "public_subnet" {
  source = "../../modules/vpc-public-subnet"

  context             = local.context
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

  nat_gateway_routing = {
    "a" = module.public_subnet.nat_gateways["eu-central-1a"]
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
