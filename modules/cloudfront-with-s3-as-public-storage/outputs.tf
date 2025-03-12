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

output "deployment_policy_id" {
  value       = aws_iam_policy.deployment_policy.arn
  description = "IAM policy for deploying CloudFront distribution."
}

output "deployment_group" {
  value       = aws_iam_group.deployment.name
  description = "Deployment group name"
}

output "deployment_group_arn" {
  value       = aws_iam_group.deployment.arn
  description = "Deployment group ARN"
}
