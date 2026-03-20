variable "project_name" {
  description = "Project name for resource naming"
  type        = string
}

variable "credentials_table_arn" {
  description = "ARN of the credentials DynamoDB table"
  type        = string
}

variable "bit_indices_table_arn" {
  description = "ARN of the bit_indices DynamoDB table"
  type        = string
}

variable "baby_jubjub_private_key_arn" {
  description = "ARN of the Baby Jubjub private key secret"
  type        = string
}

variable "hmac_key_arn" {
  description = "ARN of the HMAC key secret"
  type        = string
}

variable "artifacts_bucket_arn" {
  description = "ARN of the artifacts S3 bucket"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
