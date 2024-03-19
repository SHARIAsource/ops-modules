# SSL certificate and DNS configuration for the AWS ALB Terraform module.

data "aws_route53_zone" "main" {
  name = var.domain
}

resource "aws_acm_certificate" "alb" {
  domain_name               = var.domain
  subject_alternative_names = ["*.${var.domain}"]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name        = "${var.key}-ssl-certificate-alb-${var.environment}"
    Environment = var.environment
    Project     = var.project
    Service     = var.service
  }
}

resource "aws_route53_record" "alb" {
  for_each = {
    for dvo in aws_acm_certificate.alb.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = var.dns_ttl
  type            = each.value.type
  zone_id         = data.aws_route53_zone.main.zone_id
}

resource "aws_acm_certificate_validation" "alb" {
  certificate_arn = aws_acm_certificate.alb.arn
  validation_record_fqdns = [
    for record in aws_route53_record.alb : record.fqdn
  ]
}
