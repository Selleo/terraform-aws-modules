variable "name" {
  description = "Record name"
  type        = string
}

variable "zone_id" {
  description = "Route53 zone ID where entry will be added."
  type        = string
}

variable "lb_arn" {
  description = "Load balancer ARN. Based on data, all required attributes will be fetched."
  type        = string
}

# optional

variable "evaluate_target_health" {
  description = "Whether to evalute target health for aws_route53_record."
  type        = bool
  default     = false
}
