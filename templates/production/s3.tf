resource "random_id" "example" {
  byte_length = 4
  prefix      = "web-"
}

resource "aws_s3_bucket" "this" {
  bucket = "apps-${random_id.example.hex}"
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "app_storage" {
  bucket = "production-name-app-storage" # TODO adjust name to your project
}

module "app_storage_s3_read_write" {
  source = "../../modules/iam/s3-read-write"

  name_prefix = "name-storage" # TODO adjust name to your project
  bucket_arn  = aws_s3_bucket.app_storage.arn
  users       = [module.iam_app.name] # TODO adjust name to your project
}
