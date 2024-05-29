locals {
  tags = merge({
    "terraform.module"    = "Selleo/terraform-aws-vpc"
    "terraform.submodule" = "vpc"
    "context.namespace"   = var.context.namespace
    "context.stage"       = var.context.stage
    "context.name"        = var.context.name
    "resource.group"      = "network"
    Name                  = var.name
  })
}

resource "aws_vpc" "this" {
  cidr_block = var.cidr

  instance_tenancy                     = "default"
  enable_dns_hostnames                 = true
  enable_dns_support                   = true
  enable_network_address_usage_metrics = true

  tags = local.tags
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = local.tags
}