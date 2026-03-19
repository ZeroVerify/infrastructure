variable "project_name" {
  description = "Project name for resource naming"
  type        = string
}

variable "primary_region" {
  description = "Primary region for writes"
  type        = string
  default     = "us-east-1"
}

variable "replica_regions" {
  description = "Regions where issuer and revocation will be replicated to"
  type        = list(string)
  default     = []
}

variable "deployment_artifacts_bucket" {
  description = "Name of the S3 bucket containing Lambda deployment artifacts"
  type        = string
}

variable "issuer_lambda_role_arn" {
  description = "ARN of the issuer Lambda execution role"
  type        = string
}

variable "revocation_lambda_role_arn" {
  description = "ARN of the revocation Lambda execution role"
  type        = string
}

variable "free_lambda_role_arn" {
  description = "ARN of the free Lambda execution role"
  type        = string
}

variable "bitstring_updater_lambda_role_arn" {
  description = "ARN of the bitstring updater Lambda execution role"
  type        = string
}

variable "credentials_table_name" {
  description = "Name of the credentials DynamoDB table"
  type        = string
}

variable "credentials_table_stream_arn" {
  description = "ARN of the credentials DynamoDB table stream"
  type        = string
}

variable "bit_indices_table_name" {
  description = "Name of the bit_indices DynamoDB table"
  type        = string
}

variable "bit_indices_table_stream_arn" {
  description = "ARN of the bit_indices DynamoDB table stream"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
