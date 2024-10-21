resource "random_id" "rds" {
  byte_length = 4

  prefix = "name-aws-rds-postgres-" # TODO adjust name to your project
}


module "db" {
  source = "../modules/postgres"

  context = {
    namespace = "name" # TODO adjust name to your project
    stage     = "staging"
    name      = "database"
  }

  vpc = {
    id           = module.vpc.id
    cidr         = module.vpc.cidr # whole CIDR will have access to RDS
    subnet_group = module.private_subnet.database_subnet_group_id
  }

  identifier = random_id.rds.hex
  db_name    = "postgres" # TODO adjust name to your project
  db_user    = "user" # TODO adjust username to your project

  parameters = {
    "rds.force_ssl" = "1"
  }
  parameter_group_family = "postgres16"
  engine_version         = "16.1"

  # for easy testing:
  deletion_protection = true
  apply_immediately   = true
}
