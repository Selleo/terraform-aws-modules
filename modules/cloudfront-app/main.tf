locals {
  origin_id   = "s3-origin"
  origin_path = "/${var.apps_folder}${var.app_id}" # /apps/your-app-id

  tags = merge({
    "context.namespace" = var.context.namespace
    "context.stage"     = var.context.stage
    "context.name"      = var.context.name
  }, var.tags)
}

data "aws_s3_bucket" "apps" {
  bucket = var.s3_bucket
}

resource "random_id" "prefix" {
  byte_length = 2
}

resource "aws_cloudfront_distribution" "this" {
  comment             = "Application ${var.app_id}-${random_id.prefix.hex}"
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = var.default_root_object
  aliases             = var.aliases
  price_class         = var.price_class

  viewer_certificate {
    cloudfront_default_certificate = var.certificate_arn == "" ? true : false
    acm_certificate_arn            = var.certificate_arn
    minimum_protocol_version       = var.certificate_arn == "" ? null : var.certificate_minimum_protocol_version

    # sni-only is preferred, vip causes CloudFront to use a dedicated IP address and may incur extra charges.
    ssl_support_method = var.certificate_arn == "" ? null : "sni-only"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  origin {
    # https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-cloudfront-distribution-origin.html
    origin_id                = local.origin_id # must be unique within distribution
    origin_path              = local.origin_path
    domain_name              = data.aws_s3_bucket.apps.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.this.id
  }


  default_cache_behavior {
    target_origin_id           = local.origin_id
    cache_policy_id            = "658327ea-f89d-4fab-a63d-7e88639e58f6" # CachingOptimized
    response_headers_policy_id = "e61eb60c-9c35-4d20-a928-2b84e02af89c" # CORS-and-SecurityHeaders
    allowed_methods            = ["GET", "HEAD", "OPTIONS"]
    cached_methods             = ["GET", "HEAD"]
    viewer_protocol_policy     = "redirect-to-https"
  }

  # make sure frontend router works by redirection missing paths to index.html
  custom_error_response {
    error_code            = 403
    error_caching_min_ttl = 0
    response_code         = 200
    response_page_path    = "/"
  }

  dynamic "custom_error_response" {
    for_each = var.custom_error_responses

    content {
      error_code            = custom_error_response.value.error_code
      error_caching_min_ttl = custom_error_response.value.error_caching_min_ttl
      response_code         = custom_error_response.value.response_code
      response_page_path    = custom_error_response.value.response_page_path
    }
  }

  tags = merge(local.tags, { "resource.group" = "network" })
}

resource "aws_cloudfront_origin_access_control" "this" {
  name                              = "app-${var.app_id}-${random_id.prefix.hex}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
