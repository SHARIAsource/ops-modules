# IAM roles and permissions for the AWS SSM Tunnel Terraform module.

data "aws_iam_policy_document" "ssm_logs" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetEncryptionConfiguration",
    ]
    resources = [
      module.ssm_logs.bucket_arn
    ]

    principals {
      type        = "AWS"
      identifiers = var.allowed_roles
    }
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
    ]
    # tfsec:ignore:aws-iam-no-policy-wildcards
    resources = [
      module.ssm_logs.bucket_arn,
      "${module.ssm_logs.bucket_arn}/*",
    ]

    principals {
      type        = "AWS"
      identifiers = var.allowed_roles
    }
  }
}

resource "aws_s3_bucket_policy" "ssm_logs" {
  bucket = module.ssm_logs.bucket_id
  policy = data.aws_iam_policy_document.ssm_logs.json
}

data "aws_iam_policy_document" "jump_host_policy_assume" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "jump_host_role" {
  name               = "${var.key}-jump-host-role-${var.environment}"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.jump_host_policy_assume.json

  tags = {
    Name        = "${var.key}-jump-host-role-${var.environment}"
    Environment = var.environment
    Project     = var.project
    Service     = var.service
  }
}

data "aws_iam_policy_document" "jump_host_policy_ssm" {
  statement {
    actions = [
      "kms:Decrypt",
    ]
    resources = [
      aws_kms_key.ssm_key.arn,
    ]
  }

  statement {
    actions = [
      "ec2messages:GetMessages",
    ]
    resources = [
      "arn:aws:ssm:*:${var.aws_account}:*",
    ]
  }

  statement {
    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:GetEncryptionConfiguration",
    ]
    # tfsec:ignore:aws-iam-no-policy-wildcards
    resources = [
      module.ssm_logs.bucket_arn,
      "${module.ssm_logs.bucket_arn}/*",
    ]
  }

  statement {
    actions = [
      "ssm:ListAssociations",
      "ssm:ListInstanceAssociations",
      "ssm:UpdateInstanceInformation",
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "jump_host_policy_ssm" {
  name   = "${var.key}-jump-host-ssm-policy-${var.environment}"
  policy = data.aws_iam_policy_document.jump_host_policy_ssm.json

  tags = {
    Name        = "${var.key}-jump-host-ssm-policy-${var.environment}"
    Environment = var.environment
    Project     = var.project
    Service     = var.service
  }
}

resource "aws_iam_role_policy_attachment" "jump_host_ssm" {
  policy_arn = aws_iam_policy.jump_host_policy_ssm.arn
  role       = aws_iam_role.jump_host_role.name
}

resource "aws_iam_instance_profile" "jump_host_profile" {
  role = aws_iam_role.jump_host_role.name
  path = "/"

  tags = {
    Name        = "${var.key}-iam-instance-profile-jump-host-${var.environment}"
    Environment = var.environment
    Project     = var.project
    Service     = var.service
  }
}
