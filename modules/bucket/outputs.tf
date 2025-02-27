# Outputs for the AWS S3 Bucket Terraform module.

output "bucket_arn" {
  description = "The ARN of the s3 bucket."
  value       = module.this.s3_bucket_arn
}

output "bucket_domain_name" {
  description = "The bucket domain name. Format: 'bucketname.s3.amazonaws.com'"
  value       = module.this.s3_bucket_bucket_domain_name
}

output "bucket_id" {
  description = "The name of the bucket."
  value       = module.this.s3_bucket_id
}

output "bucket_regional_domain_name" {
  description = "The bucket region-specific domain name."
  value       = module.this.s3_bucket_bucket_regional_domain_name
}

output "bucket_website_domain" {
  description = "The domain of the website endpoint (if configured)."
  value       = module.this.s3_bucket_website_domain
}

output "bucket_website_endpoint" {
  description = "The website endpoint (if configured)."
  value       = module.this.s3_bucket_website_endpoint
}
