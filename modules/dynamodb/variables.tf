variable "project_name" {
  description = "Project name for resource naming"
  type        = string
}

variable "environment" {
  description = "Environment (e.g., dev, prod)"
  type        = string
  default     = "prod"
}

variable "primary_region" {
  description = "Primary region for DynamoDB tables"
  type        = string
  default     = "us-east-1"
}

variable "replica_region" {
  description = "Replica region for DynamoDB Global Tables"
  type        = string
  default     = "us-west-2"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
