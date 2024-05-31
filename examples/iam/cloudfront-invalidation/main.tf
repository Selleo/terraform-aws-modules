resource "aws_s3_bucket" "example_s3_bucket" {
  bucket = "tf-iam-example-s3-bucket"
  acl    = "private"
}

resource "aws_cloudfront_origin_access_identity" "example_cloudfront" {
}

resource "aws_cloudfront_distribution" "example_cloudfront" {
  origin {
    domain_name = aws_s3_bucket.example_s3_bucket.bucket_regional_domain_name
    origin_id   = "tf_iam_cloudfront_s3_origin_id"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.example_cloudfront.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "tf_iam_cloudfront_s3_origin_id"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }
  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE", "PL"]
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.example_cloudfront.domain_name
}

output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.example_cloudfront.id
}

resource "aws_iam_user" "cloudfront_user" {
  name = "cloudfront_user"
}

resource "aws_iam_access_key" "cloudfront_user" {
  user = aws_iam_user.cloudfront_user.name
}

output "iam_user_id" {
  value = aws_iam_access_key.cloudfront_user.id
}

output "iam_user_secret" {
  value     = aws_iam_access_key.cloudfront_user.secret
  sensitive = true
}

module "cloudfront_invalidation_access" {
  source      = "../../modules/cloudfront-invalidation"
  name_prefix = "aws-iam"
  cloudfront  = aws_cloudfront_distribution.example_cloudfront.arn
  users       = [aws_iam_user.cloudfront_user.name]
}
