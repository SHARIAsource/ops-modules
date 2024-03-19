# Variables for the AWS SSM Tunnel Terraform module.

variable "allowed_roles" {
  description = "AWS users/roles granted jump server permissions."
  type        = list(string)
}

variable "aws_account" {
  description = "The AWS account where resources are created."
  type        = number
}

variable "environment" {
  description = "Identify the deployment environment."
  type        = string
}

variable "force_destroy" {
  description = "Whether deletion protection is active on the bucket."
  type        = bool
}

variable "private_subnets" {
  description = "The private subnets for the VPC."
  type        = list(string)
}

variable "project" {
  description = "The project key."
  type        = string
}

variable "key" {
  description = "The project-service key."
  type        = string
}

variable "service" {
  description = "The service key."
  type        = string
}

variable "vpc_id" {
  description = "Identifier for the VPC."
  type        = string
}
