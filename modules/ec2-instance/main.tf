# Resources for the AWS EC2 Instance Terraform module.

data "aws_ami" "this" {
  most_recent = var.ami_most_recent
  name_regex  = var.ami_name_regex
  owners      = var.ami_owners

  dynamic "filter" {
    for_each = var.ami_filters

    content {
      name   = filter.value.name
      values = filter.value.values
    }
  }
}

resource "aws_security_group" "this" {
  description = "Security group for the ec2 instance."
  name_prefix = "${var.key}-security-group-ec2-${var.name}-${var.environment}-"
  vpc_id      = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name        = "${var.key}-security-group-ec2-${var.name}-${var.environment}"
    Environment = var.environment
    Project     = var.project
    Service     = var.service
  }
}

locals {
  launch_template           = "${var.key}-${var.name}-${var.environment}"
  default_security_group_id = aws_security_group.this.id
  network_interfaces = concat(
    [
      {
        associate_public_ip_address = false
        delete_on_termination       = true
        security_groups             = [aws_security_group.this.id]
        subnet_id                   = var.vpc_subnet_id
      }
    ],
    var.network_interfaces == null ? [] : var.network_interfaces,
  )
}

resource "aws_launch_template" "this" {
  name_prefix            = "${local.launch_template}-"
  image_id               = data.aws_ami.this.id
  instance_type          = var.instance_type
  update_default_version = var.update_default_version

  monitoring {
    enabled = var.monitoring
  }

  # NOTE: There are multiple options here, we can add any as they become needed.
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template#network-interfaces
  dynamic "network_interfaces" {
    for_each = var.attach_security_group ? local.network_interfaces : var.network_interfaces
    iterator = ni

    content {
      associate_public_ip_address = ni.value.associate_public_ip_address
      delete_on_termination       = ni.value.delete_on_termination
      security_groups             = try(ni.value.security_groups, [])
      subnet_id                   = try(ni.value.subnet_id, null)
    }
  }

  iam_instance_profile {
    name = var.iam_instance_profile_name
  }

  metadata_options {
    http_endpoint               = var.metadata_options.http_endpoint
    http_tokens                 = "required"
    http_put_response_hop_limit = var.metadata_options.http_put_response_hop_limit
    http_protocol_ipv6          = try(var.metadata_options.http_protocol_ipv6, null)
    instance_metadata_tags      = var.metadata_options.instance_metadata_tags
  }

  lifecycle {
    create_before_destroy = true
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

  tags = {
    Name        = local.launch_template
    Environment = var.environment
    Project     = var.project
    Service     = var.service
  }
}
