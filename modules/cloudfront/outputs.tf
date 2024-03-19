# Outputs for the AWS Cloudfront Terraform module.

output "arn" {
  description = "ARN for the distribution."
  value       = aws_cloudfront_distribution.this.arn
}
