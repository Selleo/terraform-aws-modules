terraform {
  required_version = "~> 1.0"

  backend "s3" {
    key          = "production/terraform.tfstate"
    bucket       = "name-production-tf-state" # TODO adjust name to your project
    region       = var.region
    encrypt      = true
    use_lockfile = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      terraform = 1
    }
  }
}