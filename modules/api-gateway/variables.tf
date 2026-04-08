variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "primary_region" {
  description = "Primary AWS region"
  type        = string
}

variable "replica_regions" {
  description = "List of replica AWS regions"
  type        = list(string)
  default     = []
}

variable "log_retention_days" {
  description = "Number of days to retain API Gateway logs"
  type        = number
  default     = 30
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "domain_name" {
  description = "Base domain name (e.g. zeroverify.net)"
  type        = string
}

variable "certificate_arns" {
  description = "Map of region to validated ACM certificate ARN for *.api.<domain_name>"
  type        = map(string)
}

variable "lambda_functions" {
  description = "Map of Lambda functions to integrate with API Gateway"
  type = map(object({
    invoke_arn    = map(string)
    function_name = map(string)
  }))
}

variable "routes" {
  description = "Map of API routes to Lambda function keys"
  type        = map(string)
}

variable "allowed_origins" {
  description = "List of allowed CORS origins"
  type        = list(string)
}
