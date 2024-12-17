terraform {
  required_version = "~> 1.0"

  # cloud {
  #   organization = "organization" # TODO adjust name to your project

  #   workspaces {
  #     name = "workspace" # TODO adjust name to your project
  #   }
  # }

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