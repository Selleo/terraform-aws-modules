output "dkim_verification_attrs" {
  value       = local.dkim_verification_attrs
  description = "DKIM name, value, type attributes needed to verify domain"
}

output "send_email_policy_arn" {
  value       = aws_iam_policy.this.arn
  description = "IAM policy ARN for sending emails"
}
