locals {
  ssm_ec2_policy = templatefile("${path.module}/tpl/ssm_policy.json", {
    kms_arn = var.kms_arn
  })

  ssm_access_policy = templatefile("${path.module}/tpl/ssm_access_policy.json", {
    kms_arn       = var.kms_arn
    ec2_tag_key   = var.ssm_tag_key
    ec2_tag_value = var.ssm_tag_value
    document_arn  = var.ssm_document_arn
  })
}
