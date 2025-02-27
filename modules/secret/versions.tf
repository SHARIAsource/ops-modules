# Providers for the AWS Secret Terraform module.

terraform {
  required_version = "~> 1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.32.1"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}
