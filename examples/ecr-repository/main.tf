terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "info" {
  source  = "Selleo/context/null"
  version = "0.3.0"

  namespace = "kudos"
  stage     = "production"
  name      = "api"
}

module "this" {
  source = "../../modules/ecr-repository"

  context = module.info.context
}

output "url" {
  value = module.this.url

}
