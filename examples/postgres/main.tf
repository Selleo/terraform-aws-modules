resource "random_id" "this" {
  byte_length = 4

  prefix = "selleo-aws-rds-postgres-"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 4.0"

  name = random_id.this.hex
  cidr = "10.0.0.0/16"

  azs              = ["eu-central-1a", "eu-central-1b"]
  private_subnets  = ["10.0.1.0/24"]
  database_subnets = ["10.0.51.0/24", "10.0.52.0/24"]
  public_subnets   = ["10.0.101.0/24", "10.0.102.0/24"]
}

module "db" {
  source = "../../modules/postgres"

  context = {
    namespace = "selleo"
    stage     = "dev"
    name      = "example"
  }

  vpc = {
    id           = module.vpc.vpc_id
    cidr         = module.vpc.vpc_cidr_block # whole CIDR will have access to RDS
    subnet_group = module.vpc.database_subnet_group
  }

  identifier = random_id.this.hex
  db_name    = "example"
  db_user    = "api"

  parameters = {
    "rds.force_ssl" = "1"
  }
  parameter_group_family = "postgres16"
  engine_version         = "16.1"

  # for easy testing:
  deletion_protection = false
  apply_immediately   = true
}
