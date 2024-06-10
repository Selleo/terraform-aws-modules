output "id" {
  description = "EFS ID"
  value       = aws_efs_file_system.this.id
}

output "arn" {
  description = "EFS ARN"
  value       = aws_efs_file_system.this.arn
}
