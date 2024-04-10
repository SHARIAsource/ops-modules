# Resources for the AWS ALB Terraform module.

resource "aws_security_group" "alb" {
  description = "Controls access to the ALB."
  name_prefix = "${var.key}-security-group-alb-${var.environment}"
  vpc_id      = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name        = "${var.key}-security-group-alb-${var.environment}"
    Environment = var.environment
    Project     = var.project
    Service     = var.service
  }
}

resource "aws_lb" "this" {
  drop_invalid_header_fields = true
  enable_deletion_protection = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb.id]
  subnets                    = var.subnets

  # tfsec:ignore:aws-elb-alb-not-public
  internal = false

  depends_on = [
    aws_acm_certificate_validation.alb
  ]

  lifecycle {
    ignore_changes = [
      subnets
    ]
  }

  tags = {
    Name        = "${var.key}-alb-${var.environment}"
    Environment = var.environment
    Project     = var.project
    Service     = var.service
  }
}

resource "aws_lb_target_group" "this" {
  port        = var.alb_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  load_balancing_algorithm_type = "least_outstanding_requests"

  health_check {
    healthy_threshold   = var.health_check.threshold
    interval            = var.health_check.interval
    matcher             = var.health_check.matcher
    path                = var.health_check.path
    protocol            = "HTTP"
    timeout             = var.health_check.timeout
    unhealthy_threshold = var.health_check.unhealthy_threshold
  }

  tags = {
    Name        = "${var.key}-alb-tg-${var.environment}"
    Environment = var.environment
    Project     = var.project
    Service     = var.service
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.id
  port              = var.alb_port
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = var.ssl_port
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  tags = {
    Name        = "${var.key}-alb-listener-http-${var.environment}"
    Environment = var.environment
    Project     = var.project
    Service     = var.service
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.this.id
  port              = var.ssl_port
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = aws_acm_certificate.alb.arn

  default_action {
    target_group_arn = aws_lb_target_group.this.id
    type             = "forward"
  }

  tags = {
    Name        = "${var.key}-alb-listener-https-${var.environment}"
    Environment = var.environment
    Project     = var.project
    Service     = var.service
  }
}
