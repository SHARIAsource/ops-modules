# Variables for the AWS Cloudfront Terraform module.

variable "aliases" {
  description = "Extra CNAMEs (alternate domain names), if any, for this distribution."
  type        = list(string)
  default     = null
}

variable "default_cache_behavior" {
  description = "The default cache definition for the distribution."
  type        = any
}

variable "default_root_object" {
  description = "The object to return (for example, index.html) the root URL is requested."
  type        = string
  default     = null
}

variable "dns_ttl" {
  description = "Time to live for the certificate DNS record."
  type        = number
}

variable "domain" {
  description = "The origin of the service."
  type        = string
}

variable "environment" {
  description = "Identify the deployment environment."
  type        = string
}

variable "geo_restriction" {
  description = "The geo restriction configuration for the distribution."
  type        = any
  default     = {}
}

variable "key" {
  description = "The project-service key."
  type        = string
}

variable "log_destination" {
  description = "Bucket to receive the distribution access logs."
  type        = string
}

variable "ordered_cache_behavior" {
  description = "An ordered list of cache behaviors for the distribution. The topmost cache behavior will have precedence 0 and so on."
  type        = any
  default     = []
}

variable "origin" {
  description = "One or more origins for the distribution."
  type        = any
}

variable "price_class" {
  description = "Selects the price class for the distribution."
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

variable "web_acl_id" {
  description = "Identifier for the WAF."
  type        = string
}
