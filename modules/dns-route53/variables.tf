variable "domain_name" {
  description = "Domain name"
  type        = string
}

variable "api_zone_id" {
  description = "Route53 hosted zone ID for api subdomain"
  type        = string
}

variable "api_gateway_endpoints" {
  description = "Map of region to API Gateway endpoint URLs"
  type        = map(string)
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
