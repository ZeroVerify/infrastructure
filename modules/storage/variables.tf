variable "project_name" {
  description = "Project name for resource naming"
  type        = string
}

variable "primary_region" {
  description = "Primary region for resources"
  type        = string
  default     = "us-east-1"
}

variable "replica_regions" {
  description = "Replica regions for CRR"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
