resource "random_id" "example" {
  byte_length = 4
  prefix      = "tf-example"
}

resource "aws_s3_bucket" "this" {
  bucket = "apps-${random_id.example.hex}"
}

module "cloudfront_app" {
  source = "../../modules/cloudfront-app"

  context = {
    namespace = "example"
    stage     = "dev"
    name      = "app"
  }
  app_id          = "example"
  s3_bucket       = aws_s3_bucket.this.bucket
  aliases         = []
  certificate_arn = ""
}

module "cloudfront_deployment_policy" {
  source = "../../modules/cloudfront-deployment-policy"

  s3_bucket_arn   = aws_s3_bucket.this.arn
  cloudfront_arns = [module.cloudfront_app.arn]
  s3_origin_arns  = [module.cloudfront_app.s3_origin_arn]
}

module "cloudfront_bucket_policy" {
  source = "../../modules/cloudfront-s3-origin-bucket-policy"

  s3_bucket       = aws_s3_bucket.this.bucket
  cloudfront_arns = [module.cloudfront_app.arn]
}
