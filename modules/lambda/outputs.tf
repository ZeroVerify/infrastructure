# Issuer Lambda - map of region to ARN
output "issuer_lambda_arns" {
  description = "Map of region to issuer Lambda function ARN"
  value = merge(
    {
      (data.aws_region.current.id) = aws_lambda_function.issuer.arn
    },
    {
      for region, lambda in aws_lambda_function.issuer_replica : region => lambda.arn
    }
  )
}

# Revocation Lambda - map of region to ARN
output "revocation_lambda_arns" {
  description = "Map of region to revocation Lambda function ARN"
  value = merge(
    {
      (data.aws_region.current.id) = aws_lambda_function.revocation.arn
    },
    {
      for region, lambda in aws_lambda_function.revocation_replica : region => lambda.arn
    }
  )
}

# Free Lambda - primary region only
output "free_lambda_arn" {
  description = "ARN of the free Lambda function (us-east-1 only)"
  value       = aws_lambda_function.free.arn
}

# Bitstring Updater Lambda - primary region only
output "bitstring_updater_lambda_arn" {
  description = "ARN of the bitstring updater Lambda function (us-east-1 only)"
  value       = aws_lambda_function.bitstring_updater.arn
}
