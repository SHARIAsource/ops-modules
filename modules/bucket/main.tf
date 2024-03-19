# Resources for the AWS S3 Bucket Terraform module.
#
# This is just a wrapper around the terraform-aws-modules/s3-bucket/aws with a
# simplified interface and a couple of extra namespacing conveniences
# abstracted away. I've found that these are all the parameters I tend to use
# when using the module but if we need anything else we can just expose those
# parameters in our own variables.tf file and set them as necessary. This
# wrapper also has the virtue of clearing up the output naming convention
# which, I find on the original module, is somewhat overly verbose and messy.
#
# https://github.com/terraform-aws-modules/terraform-aws-s3-bucket

locals {
  # Append the account number for extra collision entropy as buckets need to be
  # globally unique across the entirety of s3.
  bucket = "${var.key}-${var.name}-${var.environment}-${var.aws_account}"
}

# tfsec:ignore:aws-s3-enable-bucket-encryption tfsec:ignore:aws-s3-enable-bucket-logging tfsec:ignore:aws-s3-enable-versioning tfsec:ignore:aws-s3-encryption-customer-key
module "this" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.0.1"

  bucket        = local.bucket
  force_destroy = var.force_destroy

  acl                      = var.acl
  block_public_acls        = var.block_public_acls
  block_public_policy      = var.block_public_policy
  control_object_ownership = var.control_object_ownership
  ignore_public_acls       = var.ignore_public_acls
  object_ownership         = var.object_ownership
  restrict_public_buckets  = var.restrict_public_buckets

  cors_rule                            = var.cors_rules
  lifecycle_rule                       = var.lifecycle_rule
  logging                              = var.logging
  server_side_encryption_configuration = var.server_side_encryption_configuration
  versioning                           = var.versioning
  website                              = var.website

  tags = {
    Name        = local.bucket
    Environment = var.environment
    Project     = var.project
    Service     = var.service
  }
}
