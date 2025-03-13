locals {
  origin_id = "main"

  tags = merge({
    "context.namespace" = var.context.namespace
    "context.stage"     = var.context.stage
    "context.name"      = var.context.name
  }, var.tags)
}

resource "random_id" "prefix" {
  byte_length = 4
}

resource "aws_cloudfront_origin_access_control" "this" {
  name                              = "cdn-public-storage-${random_id.prefix.hex}"
  description                       = "Public Storage ${random_id.prefix.hex}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "this" {
  comment         = "Public Storage ${random_id.prefix.hex}"
  enabled         = true
  is_ipv6_enabled = true
  aliases         = var.aliases
  price_class     = var.price_class

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn            = var.certificate_arn
    minimum_protocol_version       = var.certificate_minimum_protocol_version

    # sni-only is preferred, vip causes CloudFront to use a dedicated IP address and may incur extra charges.
    ssl_support_method = "sni-only"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  origin {
    # https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-cloudfront-distribution-origin.html
    domain_name              = aws_s3_bucket.this.bucket_regional_domain_name
    origin_id                = local.origin_id # must be unique within distribution
    origin_access_control_id = aws_cloudfront_origin_access_control.this.id
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.origin_id

    response_headers_policy_id = var.response_headers_policy_id
    origin_request_policy_id   = var.origin_request_policy_id
    cache_policy_id            = aws_cloudfront_cache_policy.this.id
    compress                   = true

    viewer_protocol_policy = "redirect-to-https"
  }

  tags = merge(local.tags, { "resource.group" = "network" })
}

resource "aws_iam_policy" "deployment_policy" {
  name   = "cdn-deployment-public-storage-${random_id.prefix.hex}"
  policy = data.aws_iam_policy_document.this.json
}

data "aws_iam_policy_document" "this" {
  version = "2012-10-17"

  statement {
    sid = 1

    actions = [
      "cloudfront:CreateInvalidation",
    ]

    resources = [
      aws_cloudfront_distribution.this.arn
    ]
  }

  statement {
    sid = 2
    actions = [
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:PutObject",
    ]

    resources = [
      "${aws_s3_bucket.this.arn}/*"
    ]
  }

  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation",
    ]

    resources = [
      aws_s3_bucket.this.arn
    ]
  }
}

resource "aws_iam_group" "deployment" {
  name = "cdn-deployment-public-storage-${random_id.prefix.hex}"
}

resource "aws_iam_group_policy_attachment" "deployment" {
  group      = aws_iam_group.deployment.name
  policy_arn = aws_iam_policy.deployment_policy.arn
}


resource "aws_s3_bucket" "this" {
  bucket = var.bucket
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id

  policy = data.aws_iam_policy_document.bucket.json
}

data "aws_iam_policy_document" "bucket" {
  statement {
    sid    = "AllowCloudFrontServicePrincipalReadOnly"
    effect = "Allow"

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "arn:aws:s3:::${var.bucket}/*"
    ]

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"

      values = [
        aws_cloudfront_distribution.this.arn
      ]
    }
  }
}

resource "aws_cloudfront_cache_policy" "this" {
  name    = "cdn-public-storage-${random_id.prefix.hex}"
  comment = "Cache policy for Public Storage ${random_id.prefix.hex}"

  min_ttl     = 1
  default_ttl = 86400
  max_ttl     = 31536000

  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
    }
    headers_config {
      header_behavior = "none"
    }
    query_strings_config {
      query_string_behavior = "none"
    }
  }
}
