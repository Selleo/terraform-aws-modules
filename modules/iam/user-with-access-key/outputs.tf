output "name" {
  description = "User name."
  value       = aws_iam_user.this.name
}

output "arn" {
  description = "User ARN."
  value       = aws_iam_user.this.arn
}

output "access_key_as_envs" {
  description = "User access key map containing AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY."
  value = {
    AWS_ACCESS_KEY_ID     = aws_iam_access_key.this.id
    AWS_SECRET_ACCESS_KEY = aws_iam_access_key.this.secret
  }
  sensitive = true
}

output "key_id" {
  description = "Access key ID."
  value       = aws_iam_access_key.this.id
  sensitive   = true
}

output "key_secret" {
  description = "Access secret access key."
  value       = aws_iam_access_key.this.secret
  sensitive   = true
}
