# Outputs for the AWS RDS Terraform module.

output "security_group_id" {
  description = "Identifier for the RDS instance's security group."
  value       = aws_security_group.this.id
}
