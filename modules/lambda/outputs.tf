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

output "issuer_lambda_invoke_arns" {
  description = "Map of region to issuer Lambda invoke ARN"
  value = merge(
    {
      (data.aws_region.current.id) = aws_lambda_function.issuer.invoke_arn
    },
    {
      for region, lambda in aws_lambda_function.issuer_replica : region => lambda.invoke_arn
    }
  )
}

output "issuer_lambda_names" {
  description = "Map of region to issuer Lambda function name"
  value = merge(
    {
      (data.aws_region.current.id) = aws_lambda_function.issuer.function_name
    },
    {
      for region, lambda in aws_lambda_function.issuer_replica : region => lambda.function_name
    }
  )
}

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

output "revocation_lambda_invoke_arns" {
  description = "Map of region to revocation Lambda invoke ARN"
  value = merge(
    {
      (data.aws_region.current.id) = aws_lambda_function.revocation.invoke_arn
    },
    {
      for region, lambda in aws_lambda_function.revocation_replica : region => lambda.invoke_arn
    }
  )
}

output "revocation_lambda_names" {
  description = "Map of region to revocation Lambda function name"
  value = merge(
    {
      (data.aws_region.current.id) = aws_lambda_function.revocation.function_name
    },
    {
      for region, lambda in aws_lambda_function.revocation_replica : region => lambda.function_name
    }
  )
}

output "free_lambda_arn" {
  description = "ARN of the free Lambda function (us-east-1 only)"
  value       = aws_lambda_function.free.arn
}

output "bitstring_updater_lambda_arn" {
  description = "ARN of the bitstring updater Lambda function (us-east-1 only)"
  value       = aws_lambda_function.bitstring_updater.arn
}
