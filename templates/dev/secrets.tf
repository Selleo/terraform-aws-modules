module "name_secrets" {
  source  = "Selleo/ssm/aws//modules/parameters"
  version = "0.3.0"

  context = {
    namespace = "name" # TODO adjust name to your project
    stage     = "dev"
    name      = "name" # TODO adjust name to your project
  }

  path = "/name/dev/name/terraform"

  secrets = {
    AWS_REGION            = var.region
    AWS_ACCESS_KEY_ID     = module.iam_user_name.key_id
    AWS_SECRET_ACCESS_KEY = module.iam_user_name.key_secret
  }
}
