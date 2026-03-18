output "issuer_lambda_arn" {
  description = "ARN of the issuer Lambda function"
  value       = aws_lambda_function.issuer.arn
}

output "issuer_lambda_name" {
  description = "Name of the issuer Lambda function"
  value       = aws_lambda_function.issuer.function_name
}

output "revocation_lambda_arn" {
  description = "ARN of the revocation Lambda function"
  value       = aws_lambda_function.revocation.arn
}

output "revocation_lambda_name" {
  description = "Name of the revocation Lambda function"
  value       = aws_lambda_function.revocation.function_name
}

output "free_lambda_arn" {
  description = "ARN of the free Lambda function"
  value       = aws_lambda_function.free.arn
}

output "free_lambda_name" {
  description = "Name of the free Lambda function"
  value       = aws_lambda_function.free.function_name
}

output "bitstring_updater_lambda_arn" {
  description = "ARN of the bitstring updater Lambda function"
  value       = aws_lambda_function.bitstring_updater.arn
}

output "bitstring_updater_lambda_name" {
  description = "Name of the bitstring updater Lambda function"
  value       = aws_lambda_function.bitstring_updater.function_name
}
