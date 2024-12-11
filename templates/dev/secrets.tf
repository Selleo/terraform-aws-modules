module "dm3_secrets" {
  source  = "Selleo/ssm/aws//modules/parameters"
  version = "0.3.0"

  context = {
    namespace = "name" # TODO adjust name to your project
    stage     = "dev"
    name      = "name" # TODO adjust name to your project
  }

  path = "/ict/dev/dm3/terraform"

  secrets = {
    AWS_REGION            = var.region
    AWS_ACCESS_KEY_ID     = module.iam_user_dm3.key_id
    AWS_SECRET_ACCESS_KEY = module.iam_user_dm3.key_secret
  }
}
