output "id" {
  value       = aws_cloudfront_distribution.this.id
  description = "CDN distribution ID."
}

output "arn" {
  value       = aws_cloudfront_distribution.this.arn
  description = "CDN distribution ARN."
}

output "domain_name" {
  value       = aws_cloudfront_distribution.this.domain_name
  description = "CDN distribution's domain name."
}

output "hosted_zone_id" {
  value       = aws_cloudfront_distribution.this.hosted_zone_id
  description = "CDN Route 53 zone ID."
}

output "s3_origin_arn" {
  value       = "${data.aws_s3_bucket.apps.arn}${local.origin_path}/*"
  description = "S3 Origin ARN with origin path"
}
