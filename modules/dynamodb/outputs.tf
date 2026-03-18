output "credentials_table_name" {
  description = "Name of the credentials DynamoDB table"
  value       = aws_dynamodb_table.credentials.name
}

output "credentials_table_arn" {
  description = "ARN of the credentials DynamoDB table"
  value       = aws_dynamodb_table.credentials.arn
}

output "credentials_table_stream_arn" {
  description = "Stream ARN of the credentials DynamoDB table"
  value       = aws_dynamodb_table.credentials.stream_arn
}

output "bit_indices_table_name" {
  description = "Name of the bit_indices DynamoDB table"
  value       = aws_dynamodb_table.bit_indices.name
}

output "bit_indices_table_arn" {
  description = "ARN of the bit_indices DynamoDB table"
  value       = aws_dynamodb_table.bit_indices.arn
}

output "bit_indices_table_stream_arn" {
  description = "Stream ARN of the bit_indices DynamoDB table"
  value       = aws_dynamodb_table.bit_indices.stream_arn
}
