# Variables for the AWS SSM Terraform module.

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
