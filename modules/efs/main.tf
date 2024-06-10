locals {
  tags = {
    "context.namespace"   = var.context.namespace
    "context.stage"       = var.context.stage
    "context.name"        = var.context.name
  }
}

resource "random_id" "this" {
  byte_length = 4

  prefix = "${var.context.namespace}-${var.context.stage}-${var.context.name}-"
}

resource "aws_efs_file_system" "this" {
  creation_token   = var.name
  throughput_mode  = "bursting"
  performance_mode = "generalPurpose"
  encrypted        = true

  tags = merge(local.tags, { "Name" = var.name, "resource.group" = "storage" })
}

resource "aws_efs_mount_target" "targets" {
  count = length(var.vpc.subnets)

  file_system_id  = aws_efs_file_system.this.id
  subnet_id       = var.vpc.subnets[count.index]
  security_groups = [aws_security_group.efs.id]
}

# SG attached to EFS
resource "aws_security_group" "efs" {
  description = "Allows to connect to EFS ${random_id.this.hex}"
  name        = "${random_id.this.hex}-efs"
  vpc_id      = var.vpc.id

  tags = merge(local.tags, { "resource.group" = "network" })
}

# Allow to connect from VPC
resource "aws_security_group_rule" "efs_allow_ec2" {
  description       = "Allow VPC to access storage from EC2"
  security_group_id = aws_security_group.efs.id
  type              = "ingress"
  from_port         = 2049
  protocol          = "tcp"
  to_port           = 2049
  cidr_blocks       = var.vpc.cidr_blocks
}

resource "aws_efs_backup_policy" "this" {
  count = var.backup ? 1 : 0

  file_system_id = aws_efs_file_system.this.id

  backup_policy {
    status = "ENABLED"
  }
}
