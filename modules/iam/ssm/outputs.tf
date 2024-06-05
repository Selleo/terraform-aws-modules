output "ssm_policy_rendered" {
  description = "SSM policy to attach to EC2 role"
  value       = local.ssm_ec2_policy
}

output "ssm_access_policy_rendered" {
  description = "SSM policy to attach to IAM user/role that allows access EC2"
  value       = local.ssm_access_policy
}
