output "deployment_artifacts_bucket_name" {
  description = "Name of the Lambda artifacts S3 bucket"
  value       = aws_s3_bucket.deployment_artifacts.bucket
}

output "deployment_artifacts_bucket_arn" {
  description = "ARN of the Lambda artifacts S3 bucket"
  value       = aws_s3_bucket.deployment_artifacts.arn
}
