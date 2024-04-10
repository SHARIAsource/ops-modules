# Resources for the AWS RDS Terraform module.

locals {
  apply_method = contains(["development", "staging"], var.environment) ? "immediate" : "pending-reboot"
  family       = "${var.engine}${var.engine_version}"
  identifier   = "${var.key}-${var.identifier}-${var.environment}"
}

resource "aws_db_parameter_group" "this" {
  family = local.family
  name   = "${var.key}-rds-parameter-group-${var.environment}"

  lifecycle {
    create_before_destroy = true
  }

  parameter {
    # Enforce SSL connections.
    name         = "rds.force_ssl"
    value        = var.parameter_rds_force_ssl
    apply_method = local.apply_method
  }

  tags = {
    Name        = "${var.key}-rds-parameter-group-${var.environment}"
    Environment = var.environment
    Project     = var.project
    Service     = var.service
  }
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.key}-subnet-group-postgres-${var.environment}"
  subnet_ids = var.subnet_ids

  tags = {
    Name        = "${var.key}-subnet-group-postgres-${var.environment}"
    Environment = var.environment
    Project     = var.project
    Service     = var.service
  }
}

resource "aws_security_group" "this" {
  description = "Security group for the RDS instance."
  name_prefix = "${var.key}-security-group-postgres-${var.environment}-"
  vpc_id      = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name        = "${var.key}-security-group-postgres-${var.environment}"
    Environment = var.environment
    Project     = var.project
    Service     = var.service
  }
}

resource "aws_db_instance" "this" {
  allocated_storage                     = var.allocated_storage
  apply_immediately                     = var.apply_immediately
  backup_retention_period               = var.backup_retention_period
  db_name                               = var.db_name
  db_subnet_group_name                  = aws_db_subnet_group.this.name
  deletion_protection                   = var.deletion_protection # tfsec:ignore:AVD-AWS-0177
  engine                                = var.engine
  engine_version                        = var.engine_version
  iam_database_authentication_enabled   = var.iam_database_authentication_enabled
  identifier                            = local.identifier
  instance_class                        = var.instance_class
  kms_key_id                            = var.kms_key_arn
  manage_master_user_password           = var.manage_master_user_password
  master_user_secret_kms_key_id         = var.kms_key_arn
  multi_az                              = var.multi_az
  parameter_group_name                  = aws_db_parameter_group.this.name
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_kms_key_id       = var.kms_key_arn
  performance_insights_retention_period = var.performance_insights_retention_period
  port                                  = var.port
  publicly_accessible                   = var.publicly_accessible
  skip_final_snapshot                   = var.skip_final_snapshot
  storage_encrypted                     = var.storage_encrypted
  storage_type                          = var.storage_type
  username                              = var.username
  vpc_security_group_ids                = [aws_security_group.this.id]

  tags = {
    Name        = local.identifier
    Environment = var.environment
    Project     = var.project
    Service     = var.service
  }
}
