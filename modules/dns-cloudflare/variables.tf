variable "domain_name" {
  description = "Domain name"
  type        = string
}

variable "cloudflare_zone_id" {
  description = "Cloudflare zone ID"
  type        = string
}

variable "api_name_servers" {
  description = "Route53 nameservers for api subdomain"
  type        = list(string)
}
