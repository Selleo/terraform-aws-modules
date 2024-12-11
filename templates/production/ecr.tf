module "info" {
  source  = "Selleo/context/null"
  version = "0.3.0"

  namespace = "name" # TODO adjust name to your project
  stage     = "production"
  name      = "api"
}

module "ecr" {
  source = "../modules/ecr-repository"

  context = {  
    namespace = "name" # TODO adjust name to your project
    stage     = "production"
    name      = "api"
  }
}

output "url" {
  value = module.ecr.url

}
