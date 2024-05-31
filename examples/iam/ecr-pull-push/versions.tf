terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  required_version = "~> 1.0.5"
}

provider "aws" {
  region = "eu-central-1"
}
