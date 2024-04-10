# Resources for the AWS SSM Tunnel Terraform module.
#
# This modules provisions an ec2 jump server allowing secure tunnelling into
# the vpc via the AWS SSM service.

# Use an independent kms key for ssm to airlock the jump server.
resource "aws_kms_key" "ssm_key" {
  description             = "Encrypts SSM user sessions."
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = {
    Name        = "${var.key}-kms-key-ssm-${var.environment}"
    Environment = var.environment
    Project     = var.project
    Service     = var.service
  }
}

module "ssm_logs" {
  source = "..//bucket/"

  acl                      = "log-delivery-write"
  aws_account              = var.aws_account
  control_object_ownership = true
  environment              = var.environment
  force_destroy            = var.force_destroy
  key                      = var.key
  name                     = "logs-ssm"
  object_ownership         = "ObjectWriter"
  project                  = var.project
  service                  = var.service

  lifecycle_rule = [
    {
      id     = "ssm"
      status = "Enabled"

      filter = {
        prefix = "/"
      }

      expiration = {
        days = 90
      }

      noncurrent_version_expiration = {
        noncurrent_days = 90
      }

      noncurrent_version_transition = {
        noncurrent_days = 30
        storage_class   = "STANDARD_IA"
      }
    }
  ]

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = true
    }
  }

  versioning = {
    enabled = true
  }
}

resource "aws_ssm_document" "session_manager" {
  name            = "SSM-SessionManagerRunShell"
  document_type   = "Session"
  document_format = "JSON"

  content = templatefile("${path.module}/files/ssm-session.json.tmpl", {
    aws_account = var.aws_account
    key_id      = aws_kms_key.ssm_key.id
    logs_bucket = module.ssm_logs.bucket_id
  })

  tags = {
    Name        = "${var.key}-ssm-document-session-manager-${var.environment}"
    Environment = var.environment
    Project     = var.project
    Service     = var.service
  }
}

locals {
  launch_template = "${var.key}-ssm-jump-host-${var.environment}"
}

data "aws_ami" "amazon-linux-2" {
  most_recent = true
  name_regex  = "^amzn2-ami-hvm.*-ebs"
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_launch_template" "jump_host" {
  name_prefix            = "${local.launch_template}-"
  image_id               = data.aws_ami.amazon-linux-2.id
  instance_type          = "t3.nano"
  update_default_version = true

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
    security_groups = [
      aws_security_group.jump_host.id,
    ]
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.jump_host_profile.name
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      "Name"        = local.launch_template
      "Environment" = var.environment
      "Project"     = var.project
      "Service"     = var.service
    }
  }

  tag_specifications {
    resource_type = "volume"
    tags = {
      "Name"        = local.launch_template
      "Environment" = var.environment
      "Project"     = var.project
      "Service"     = var.service
    }
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required" # SOC2
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name        = local.launch_template
    Environment = var.environment
    Project     = var.project
    Service     = var.service
  }
}

# A 'self-healing' autoscaling group for the jump host that will provision a
# new server (maybe in a different AZ if necessary) if an existing host (or AZ)
# has become unavailable.
resource "aws_autoscaling_group" "jump_host" {
  name_prefix      = "${var.key}-asg-jump-host-${var.environment}-"
  max_size         = 1
  min_size         = 1
  desired_capacity = 1

  vpc_zone_identifier = var.private_subnets

  default_cooldown          = 180
  health_check_grace_period = 180
  health_check_type         = "EC2"

  launch_template {
    id      = aws_launch_template.jump_host.id
    version = aws_launch_template.jump_host.latest_version
  }

  termination_policies = [
    "OldestLaunchConfiguration",
  ]

  instance_refresh {
    strategy = "Rolling"
  }

  tag {
    key                 = "Name"
    value               = "${var.key}-asg-jump-host-${var.environment}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = var.environment
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = var.project
    propagate_at_launch = true
  }

  tag {
    key                 = "Service"
    value               = var.service
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "jump_host" {
  description = "Security group for the ec2 jump host."
  name_prefix = "${var.key}-security-group-jump-host-${var.environment}-"
  vpc_id      = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name        = "${var.key}-security-group-jump-host-${var.environment}"
    Environment = var.environment
    Project     = var.project
    Service     = var.service
  }
}
