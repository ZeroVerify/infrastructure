variable "domain_name" {
  description = "Domain name for the hosted zone"
  type        = string
}

variable "cloudflare_zone_id" {
  description = "Cloudflare zone ID"
  type        = string
}

variable "api_gateway_endpoints" {
  description = "Map of region to API Gateway endpoint URLs"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
