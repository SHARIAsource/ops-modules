# Resources for the AWS ECS cluster Terraform module.

resource "aws_ecs_cluster" "this" {
  name = "${var.key}-ecs-cluster-${var.environment}"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name        = "${var.key}-ecs-cluster-${var.environment}"
    Environment = var.environment
    Project     = var.project
    Service     = var.service
  }
}

resource "aws_ecs_cluster_capacity_providers" "this" {
  cluster_name = aws_ecs_cluster.this.name

  capacity_providers = var.capacity_providers

  default_capacity_provider_strategy {
    base              = var.default_capacity_provider_strategy.base
    weight            = var.default_capacity_provider_strategy.weight
    capacity_provider = var.default_capacity_provider_strategy.capacity_provider
  }
}

resource "aws_security_group" "ecs" {
  description = "Controls access to the ECS cluster."
  name_prefix = "${var.key}-security-group-ecs-${var.environment}-"
  vpc_id      = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name        = "${var.key}-security-group-ecs-${var.environment}"
    Environment = var.environment
    Project     = var.project
    Service     = var.service
  }
}
