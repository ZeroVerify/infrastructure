output "deployment_artifacts_bucket_name" {
  description = "Names of the Lambda artifacts S3 buckets by region"
  value       = { for region, bucket in aws_s3_bucket.deployment_artifacts : region => bucket.bucket }
}

output "deployment_artifacts_bucket_arn" {
  description = "ARNs of the Lambda artifacts S3 buckets by region"
  value       = { for region, bucket in aws_s3_bucket.deployment_artifacts : region => bucket.arn }
}

output "artifacts_bucket_name" {
  description = "Name of the public artifacts S3 bucket"
  value       = aws_s3_bucket.artifacts.bucket
}

output "artifacts_bucket_arn" {
  description = "ARN of the public artifacts S3 bucket"
  value       = aws_s3_bucket.artifacts.arn
}

output "artifacts_bucket_domain_name" {
  description = "Domain name of the artifacts bucket"
  value       = aws_s3_bucket.artifacts.bucket_domain_name
}

output "artifacts_bucket_regional_domain_name" {
  description = "Regional domain name of the artifacts bucket"
  value       = aws_s3_bucket.artifacts.bucket_regional_domain_name
}
