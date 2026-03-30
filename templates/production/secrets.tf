module "secrets" {
  source  = "../../modules/ssm/parameters"

  context = {
    namespace = "name" # TODO adjust name to your project
    stage     = "production"
    name      = "service" # TODO adjust name to your project
  }

  secrets = {
    NODE_ENV              = "production"
    DATABASE_URL          = module.db.url
    AWS_REGION            = var.region
  }

  editable_secrets = {
    CORS_ORIGIN            = "Edit in AWS Console"
    ENVIRONMENT            = "Edit in AWS Console"
  }
}