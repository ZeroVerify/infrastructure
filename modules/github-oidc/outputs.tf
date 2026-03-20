output "oidc_provider_arn" {
  description = "ARN of the GitHub OIDC provider"
  value       = aws_iam_openid_connect_provider.github.arn
}

output "infrastructure_role_arn" {
  description = "ARN of the infrastructure IAM role"
  value       = aws_iam_role.infrastructure.arn
}

output "infrastructure_role_name" {
  description = "Name of the infrastructure IAM role"
  value       = aws_iam_role.infrastructure.name
}

output "lambda_deployment_role_arn" {
  description = "ARN of the lambda deployment IAM role"
  value       = aws_iam_role.lambda_deployment.arn
}

output "lambda_deployment_role_name" {
  description = "Name of the lambda deployment IAM role"
  value       = aws_iam_role.lambda_deployment.name
}

output "artifact_upload_role_arn" {
  description = "ARN of the artifact upload IAM role"
  value       = aws_iam_role.artifact_upload.arn
}

output "artifact_upload_role_name" {
  description = "Name of the artifact upload IAM role"
  value       = aws_iam_role.artifact_upload.name
}
