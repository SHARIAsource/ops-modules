# Variables for the AWS ECS cluster Terraform module.

variable "capacity_providers" {
  description = "Determine where the ECS scaling provisioning comes from."
  type        = list(string)
}

variable "default_capacity_provider_strategy" {
  description = "Tune the ECS capacity provider strategy"
  type = object({
    base              = number,
    weight            = number,
    capacity_provider = string,
  })
}

variable "environment" {
  description = "Identify the deployment environment."
  type        = string
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

variable "vpc_id" {
  description = "Identifier for the VPC."
  type        = string
}
