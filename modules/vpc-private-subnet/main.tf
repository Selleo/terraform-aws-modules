locals {
  tags = merge({
    "terraform.module"    = "Selleo/terraform-aws-vpc"
    "terraform.submodule" = "private-subnet"
    "context.namespace"   = var.context.namespace
    "context.stage"       = var.context.stage
    "context.name"        = var.context.name
    "resource.group"      = "network"
  })
}

resource "aws_subnet" "this" {
  for_each = var.config

  vpc_id                  = var.vpc_id
  availability_zone       = each.value.az
  cidr_block              = each.value.cidr
  map_public_ip_on_launch = false

  tags = merge(local.tags, {
    Name = "private-${random_id.this.hex}-${each.key}--${each.value.az}"
  })
}

resource "aws_route_table" "this" {
  for_each = var.config

  vpc_id = var.vpc_id

  tags = merge(local.tags, {
    Name = "private-${random_id.this.hex}-${each.key}--${each.value.az}"
  })
}

resource "aws_route_table_association" "this" {
  for_each = var.config

  subnet_id      = aws_subnet.this[each.key].id
  route_table_id = aws_route_table.this[each.key].id
}

resource "aws_route" "this" {
  for_each = var.nat_gateway_routing

  route_table_id         = aws_route_table.this[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = each.value

  timeouts {
    create = "5m"
  }
}

resource "aws_db_subnet_group" "this" {
  for_each = var.database_subnet ? { "db" : true } : {}

  name        = "db-private-${random_id.this.hex}"
  description = "Database subnet group for RDS"
  subnet_ids  = [for key in sort(keys(var.config)) : aws_subnet.this[key].id]

  tags = merge(local.tags, { "resource.group" = "network" })
}

resource "random_id" "this" {
  byte_length = 2
}
