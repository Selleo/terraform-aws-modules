locals {
  tags = merge({
    "terraform.module"    = "Selleo/terraform-aws-vpc"
    "terraform.submodule" = "public-subnet"
    "context.namespace"   = var.context.namespace
    "context.stage"       = var.context.stage
    "context.name"        = var.context.name
    "resource.group"      = "network"
    Name                  = "public"
  })

  # if nat is enabled, create a NAT gateway in each AZ
  nat_enabled_azs = {
    for key, config in var.config :
    key => config if config.nat
  }
}

resource "aws_route_table" "main" {
  vpc_id = var.vpc_id

  tags = merge(local.tags, {
    Name = "public-${random_id.this.hex}"
  })
}

resource "aws_subnet" "this" {
  for_each = var.config

  vpc_id                  = var.vpc_id
  availability_zone       = each.value.az
  cidr_block              = each.value.cidr
  map_public_ip_on_launch = true

  tags = merge(local.tags, {
    Name = "public-${random_id.this.hex}-${each.key}--${each.value.az}"
  })
}

resource "aws_route_table_association" "this" {
  for_each = var.config

  subnet_id      = aws_subnet.this[each.key].id
  route_table_id = aws_route_table.main.id
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.main.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.internet_gateway_id

  timeouts {
    create = "5m"
  }
}

resource "aws_eip" "nat" {
  for_each = local.nat_enabled_azs

  tags = merge(local.tags, {
    Name = "nat-${random_id.this.hex}-${each.key}--${each.value.az}"
  })
}

resource "aws_nat_gateway" "nat" {
  for_each = local.nat_enabled_azs

  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = aws_subnet.this[each.key].id

  tags = merge(local.tags, {
    Name = "nat-${random_id.this.hex}-${each.key}--${each.value.az}"
  })
}

resource "random_id" "this" {
  byte_length = 2
}