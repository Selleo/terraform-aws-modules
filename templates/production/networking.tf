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