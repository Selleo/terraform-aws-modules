resource "random_id" "example" {
  byte_length = 4

  prefix = "efs-"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.2"

  name = random_id.example.hex
  cidr = "10.0.0.0/16"

  azs             = ["eu-central-1a", "eu-central-1b"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  single_nat_gateway = true
  enable_nat_gateway = false
  enable_vpn_gateway = false
}


module "efs" {
  source = "../../modules/efs"

  context = {
    namespace = "selleo"
    stage     = "test"
    name      = "logs"
  }

  name = random_id.example.hex
  vpc = {
    id          = module.vpc.vpc_id
    subnets     = module.vpc.public_subnets
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }
  backup = true
}
