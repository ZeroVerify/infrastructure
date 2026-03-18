output "issuer_lambda_role_arn" {
  description = "ARN of the issuer Lambda execution role"
  value       = aws_iam_role.issuer_lambda.arn
}

output "issuer_lambda_role_name" {
  description = "Name of the issuer Lambda execution role"
  value       = aws_iam_role.issuer_lambda.name
}

output "revocation_lambda_role_arn" {
  description = "ARN of the revocation Lambda execution role"
  value       = aws_iam_role.revocation_lambda.arn
}

output "revocation_lambda_role_name" {
  description = "Name of the revocation Lambda execution role"
  value       = aws_iam_role.revocation_lambda.name
}

output "free_lambda_role_arn" {
  description = "ARN of the free Lambda execution role"
  value       = aws_iam_role.free_lambda.arn
}

output "free_lambda_role_name" {
  description = "Name of the free Lambda execution role"
  value       = aws_iam_role.free_lambda.name
}

output "bitstring_updater_lambda_role_arn" {
  description = "ARN of the bitstring updater Lambda execution role"
  value       = aws_iam_role.bitstring_updater_lambda.arn
}

output "bitstring_updater_lambda_role_name" {
  description = "Name of the bitstring updater Lambda execution role"
  value       = aws_iam_role.bitstring_updater_lambda.name
}
