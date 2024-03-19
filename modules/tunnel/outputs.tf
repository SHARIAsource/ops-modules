# Outputs for the AWS SSM Tunnel Terraform module.

output "security_group_id" {
  description = "Identifier for the tunnel's security group."
  value       = aws_security_group.jump_host.id
}
