variable "domain_name" {
  description = "Base domain name"
  type        = string
}

variable "api_zone_id" {
  description = "Route53 hosted zone ID for the api subdomain"
  type        = string
}

variable "primary_region" {
  description = "Primary AWS region"
  type        = string
}

variable "replica_regions" {
  description = "Replica AWS regions"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
