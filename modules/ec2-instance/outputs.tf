# Outputs for the AWS EC2 Instance Terraform module.

output "launch_template_id" {
  description = "Identifier for the ec2 launch template."
  value       = aws_launch_template.this.id
}

output "launch_template_latest_version" {
  description = "Latest version of the ec2 launch template."
  value       = aws_launch_template.this.latest_version
}

output "security_group_id" {
  description = "Identifier for the ec2 instance's security group."
  value       = aws_security_group.this.id
}
