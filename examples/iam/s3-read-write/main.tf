resource "aws_s3_bucket" "example_s3_bucket" {
  bucket = "tf-iam-example-s3-bucket"
  acl    = "private"
}

resource "aws_iam_user" "s3_user" {
  name = "s3_user"
}

resource "aws_iam_access_key" "s3_user" {
  user = aws_iam_user.s3_user.name
}

output "iam_user_id" {
  value = aws_iam_access_key.s3_user.id
}

output "iam_user_secret" {
  value     = aws_iam_access_key.s3_user.secret
  sensitive = true
}

module "s3_full_access_policy" {
  source      = "../../modules/s3-read-write"
  name_prefix = "aws-iam"
  bucket_arn  = aws_s3_bucket.example_s3_bucket.arn
  users       = [aws_iam_user.s3_user.name]
}
