output "user_key_id" {
  value = aws_iam_access_key.this.id
}

output "user_secret" {
  value     = aws_iam_access_key.this.ses_smtp_password_v4
  sensitive = true
}

output "dkim_verification_attrs" {
  value = module.ses.dkim_verification_attrs
}

output "domain_identity_verification_attrs" {
  value = module.ses.domain_identity_verification_attrs
}
