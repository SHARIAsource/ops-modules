# Resources for the AWS OIDC Terraform module.

locals {
  gh_path      = "token.actions.githubusercontent.com"
  harvard_path = "token.actions.githubusercontent.com/harvard-university"
  role_name    = "${var.key}-${var.gha_oidc_role_name}-${var.environment}"
  thumbprint   = data.tls_certificate.github.certificates[0].sha1_fingerprint
}

locals {
  path = var.environment == "development" ? local.gh_path : local.harvard_path
}

locals {
  url = "https://${local.path}"
}

data "tls_certificate" "github" {
  url = local.url
}

resource "aws_iam_openid_connect_provider" "github" {
  url             = local.url
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [local.thumbprint]

  tags = {
    Name        = "${var.key}-oidc-provider-${var.environment}"
    Environment = var.environment
    Project     = var.project
    Service     = var.service
  }
}

data "aws_iam_policy_document" "this" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      identifiers = [aws_iam_openid_connect_provider.github.arn]
      type        = "Federated"
    }

    condition {
      test     = "StringEquals"
      variable = "${local.path}:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.path}:sub"
      values = concat(
        [
          for item in var.oidc_allowed :
          "repo:${item["org"]}/${item["repo"]}:pull_request"
        ],
        [
          for item in var.oidc_allowed :
          "repo:${item["org"]}/${item["repo"]}:ref:refs/heads/${item["branch"]}"
        ],
      )
    }
  }
}

resource "aws_iam_role" "this" {
  name               = local.role_name
  assume_role_policy = data.aws_iam_policy_document.this.json

  tags = {
    Name        = local.role_name
    Environment = var.environment
    Project     = var.project
    Service     = var.service
  }
}
