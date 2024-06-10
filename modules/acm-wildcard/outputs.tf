output "arn" {
  description = "Certifcate ARN"
  value       = aws_acm_certificate.this.arn
}

output "zone_id" {
  description = "Route53 zone ID"
  value       = try(data.aws_route53_zone.this[0].zone_id, null)
}

output "validation_records" {
  description = "Map of DNS records used for certificate validation."
  value       = local.dvo_records
}
