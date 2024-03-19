# Variables for the AWS OIDC Terraform module.

variable "environment" {
  description = "Identify the deployment environment."
  type        = string
}

variable "gha_oidc_role_name" {
  description = "Name of the github action OIDC role."
  type        = string
}

variable "oidc_allowed" {
  description = "Github org/repos/branches allowed to assume to OIDC role."
  type        = list(map(string))
}

variable "key" {
  description = "The project-service key."
  type        = string
}

variable "project" {
  description = "The project key."
  type        = string
}

variable "service" {
  description = "The service key."
  type        = string
}
