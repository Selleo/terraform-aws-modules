resource "aws_s3_bucket" "apps_storage" {
  bucket = "apps-name" # TODO adjust name to your project
}

resource "aws_s3_bucket_public_access_block" "apps_policy" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

module "cloudfront_app" {
  source = "../../modules/cloudfront-app"

  context = {
    namespace = "template" # TODO adjust namespace to your project name
    stage     = "production"
    name      = "app"
  }
  app_id          = "example" # TODO adjust app_id to your project name
  s3_bucket       = aws_s3_bucket.this.bucket
  aliases         = [] # fill with proper domains
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
