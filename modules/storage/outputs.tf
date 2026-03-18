output "lambda_artifacts_bucket_name" {
  description = "Name of the Lambda artifacts S3 bucket"
  value       = aws_s3_bucket.lambda_artifacts.bucket
}

output "lambda_artifacts_bucket_arn" {
  description = "ARN of the Lambda artifacts S3 bucket"
  value       = aws_s3_bucket.lambda_artifacts.arn
}
