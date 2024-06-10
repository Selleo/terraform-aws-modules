locals {
  tags = {
    "context.namespace"   = var.context.namespace
    "context.stage"       = var.context.stage
    "context.name"        = var.context.name
  }

  db_name = var.db_name
  db_user = var.db_user
  db_port = var.port
  db_host = aws_db_instance.this.address
  db_pass = random_password.this.result
  db_url  = "postgres://${local.db_user}:${local.db_pass}@${local.db_host}:${local.db_port}/${local.db_name}"
  id      = random_id.this.hex
}

resource "random_id" "this" {
  byte_length = 2
  prefix      = "${var.identifier}-"
}

resource "random_password" "this" {
  length  = var.password_length
  special = false
}

resource "aws_db_parameter_group" "this" {
  name   = local.id
  family = var.parameter_group_family

  parameter {
    name  = "autovacuum"
    value = 1
  }

  parameter {
    name  = "client_encoding"
    value = "utf8"
  }

  dynamic "parameter" {
    for_each = var.parameters

    content {
      name  = parameter.key
      value = parameter.value
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(local.tags, { "resource.group" = "database" })
}

resource "aws_cloudwatch_log_group" "this_postgresql" {
  name              = "/aws/rds/instance/${local.id}/postgresql"
  retention_in_days = var.logs_retention_in_days

  tags = merge(local.tags, { "resource.group" = "log" })
}

resource "aws_cloudwatch_log_group" "this_upgrade" {
  name              = "/aws/rds/instance/${local.id}/upgrade"
  retention_in_days = var.logs_retention_in_days

  tags = merge(local.tags, { "resource.group" = "log" })
}

resource "aws_db_instance" "this" {
  identifier = local.id

  engine         = "postgres"
  engine_version = var.engine_version

  instance_class        = var.instance_class
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_encrypted     = true

  db_name  = local.db_name
  username = local.db_user
  password = local.db_pass
  port     = local.db_port

  vpc_security_group_ids = [aws_security_group.this.id]
  db_subnet_group_name   = var.vpc.subnet_group
  parameter_group_name   = aws_db_parameter_group.this.id

  multi_az            = var.multi_az
  publicly_accessible = var.publicly_accessible

  allow_major_version_upgrade = var.allow_major_version_upgrade
  auto_minor_version_upgrade  = false
  apply_immediately           = var.apply_immediately
  maintenance_window          = var.maintenance_window

  copy_tags_to_snapshot = true
  skip_final_snapshot   = true
  snapshot_identifier   = var.snapshot_identifier

  performance_insights_enabled          = var.performance_insights != null
  performance_insights_retention_period = try(var.performance_insights.retention_period, 7)
  performance_insights_kms_key_id       = try(var.performance_insights.kms_key_id, null)

  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window

  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]

  deletion_protection      = var.deletion_protection
  delete_automated_backups = true

  tags = merge(local.tags, { "resource.group" = "database" })

  depends_on = [
    aws_cloudwatch_log_group.this_upgrade,
    aws_cloudwatch_log_group.this_postgresql,
  ]
}

resource "aws_security_group" "this" {
  name        = "${local.id}-rds"
  description = "Allow RDS access from within VPC (${var.identifier})"
  vpc_id      = var.vpc.id

  tags = merge(local.tags, { "resource.group" = "network" })
}

resource "aws_security_group_rule" "ingress_with_cidr_blocks" {
  security_group_id = aws_security_group.this.id
  type              = "ingress"
  description       = "PostgreSQL access from within VPC"

  from_port   = var.port
  to_port     = var.port
  protocol    = "tcp"
  cidr_blocks = [var.vpc.cidr]
}
