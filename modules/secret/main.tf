# Resources for the AWS Secret Terraform module.

resource "random_password" "this" {
  length           = var.length
  special          = true
  min_special      = var.min_special
  override_special = var.override_special
  # https://registry.terraform.io/providers/hashicorp/random/latest/docs#resource-keepers
  keepers = var.keepers
}

locals {
  random_secret = random_password.this.result
}

locals {
  name          = "${var.key}-secret-${var.name}-${var.environment}"
  secret_string = var.username_password_pair == true && var.username != null ? jsonencode({ username = var.username, password = local.random_secret }) : local.random_secret
}

resource "aws_secretsmanager_secret" "this" {
  name                    = local.name
  description             = var.description
  kms_key_id              = var.kms_key_arn
  recovery_window_in_days = var.recovery_window

  dynamic "replica" {
    for_each = var.region != null ? { render = true } : {}

    content {
      kms_key_id = var.kms_key_arn
      region     = var.region
    }
  }

  tags = {
    Name        = local.name
    Environment = var.environment
    Project     = var.project
    Service     = var.service
  }
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = local.secret_string
}
