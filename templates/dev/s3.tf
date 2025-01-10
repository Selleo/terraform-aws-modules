resource "aws_s3_bucket" "storage" {
  bucket = "name" # TODO adjust name to your project
}

module "storage_s3_read_write" {
  source = "../../modules/iam/s3-read-write"

  name_prefix = "name" # TODO adjust name to your project
  bucket_arn  = aws_s3_bucket.storage.arn
  users       = [module.iam.name]
}

module "iam" {
  source  = "../../modules/iam/user-with-access-key"

  name = "name" # TODO adjust name to your project
}

module "secrets" {
  source  = "Selleo/ssm/aws//modules/parameters"
  version = "0.4.0"

  context = {
    namespace = "name" # TODO adjust name to your project
    stage     = "dev"
    name      = "name" # TODO adjust name to your project
  }

  secrets = {
    AWS_REGION            = var.region
    AWS_S3_BUCKET         = aws_s3_bucket.storage.id
    AWS_ACCESS_KEY_ID     = module.iam.key_id
    AWS_SECRET_ACCESS_KEY = module.iam.key_secret
  }
}
