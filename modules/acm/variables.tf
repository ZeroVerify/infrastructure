variable "domain_name" {
  description = "Base domain name"
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
