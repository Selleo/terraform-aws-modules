module "info" {
  source  = "Selleo/context/null"
  version = "0.3.0"

  namespace = "kudos"
  stage     = "developemnt"
  name      = "api"
}

module "cert" {
  source = "../../modules/acm-wildcard"

  domain   = "hetzner.example.selleo.com"
  context  = module.info.context
  validate = false
}

output "records" {
  value = module.cert.validation_records
}
