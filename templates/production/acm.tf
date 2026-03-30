data "aws_route53_zone" "name" { # TODO adjust name to your project
  provider = aws.global
  name  = "example.com" # TODO adjust name to your project
}

module "cert" {
  providers = {
    aws = aws.global
  }  

  source = "../../modules/acm-wildcard"

  domain          = "example.com" # TODO adjust name to your project
  validation_zone = "example.com" # TODO adjust name to your project
  wildcard = true
  validate = true
  
  context = {
    namespace = "name" # TODO adjust name to your project
    stage     = "production"
    name      = "acm"
  }
}