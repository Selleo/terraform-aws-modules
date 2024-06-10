variable "load_balancer_arn" {
  description = "Load balancer ARN"
  type = string
}

variable "certificate_arn" {
  description = "ACM certificate ARN"
  type = string
}

variable "target_group_arn" {
  description = "Target group ARN from ECS service"
  type = string
}

variable "ssl_policy" {
  description = <<-EOS
  SSL policy.
  [Available policies here](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/create-https-listener.html)
  EOS
  default = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
  type = string
}
