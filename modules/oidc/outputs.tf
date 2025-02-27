# Outputs for the AWS OIDC Terraform module.

output "gha_oidc_provider_arn" {
  description = "The ARN of the github OIDC provider resource."
  value       = aws_iam_openid_connect_provider.github.arn
}

output "gha_oidc_role_name" {
  description = "The name of the Github Actions OIDC role."
  value       = aws_iam_role.this.name
}
