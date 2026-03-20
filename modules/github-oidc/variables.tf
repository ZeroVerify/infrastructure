variable "infrastructure_repositories" {
  description = "List of GitHub repositories for infrastructure management (admin access)"
  type        = list(string)
}

variable "lambda_deployment_repositories" {
  description = "List of GitHub repositories for deployments (limited S3 + Lambda access)"
  type        = list(string)
}

variable "artifact_repositories" {
  description = "List of GitHub repositories for uploading artifacts (circuits, bitstrings)"
  type        = list(string)
}

variable "infrastructure_role_name" {
  description = "Name of the IAM role for infrastructure management"
  type        = string
  default     = "GitHubActionsInfrastructure"
}

variable "lambda_deployment_role_name" {
  description = "Name of the IAM role for deployments"
  type        = string
  default     = "GitHubActionsDeployment"
}

variable "aws_region" {
  description = "AWS region for resources"
  type        = string
}

variable "deployment_artifacts_bucket_arn" {
  description = "Map of region to ARN of the deployment artifacts S3 buckets"
  type        = map(string)
}

variable "artifacts_bucket_arn" {
  description = "ARN of the public artifacts S3 bucket"
  type        = string
}

variable "artifact_deployment_role_name" {
  description = "Name of the IAM role for artifact uploads"
  type        = string
  default     = "GitHubActionsArtifactUpload"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
