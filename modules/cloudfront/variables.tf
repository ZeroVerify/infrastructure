variable "domain_name" {
  description = "Base domain name"
  type        = string
}

variable "bucket_regional_domain_name" {
  description = "Regional domain name of the artifacts S3 bucket"
  type        = string
}

variable "api_zone_id" {
  description = "Route53 hosted zone ID for the api subdomain"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
