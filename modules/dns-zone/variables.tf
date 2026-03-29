variable "domain_name" {
  description = "Base domain name (e.g. zeroverify.net)"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
