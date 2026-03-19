variable "project_name" {
  description = "Project name for resource naming"
  type        = string
}

variable "replica_regions" {
  description = "List of replica regions for DynamoDB Global Tables"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
