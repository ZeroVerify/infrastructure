# Credentials table
output "credentials_table_name" {
  description = "Name of the credentials DynamoDB table"
  value       = aws_dynamodb_table.credentials.name
}

output "credentials_table_arns" {
  description = "Map of region to credentials table ARN"
  value = merge(
    {
      (data.aws_region.current.id) = aws_dynamodb_table.credentials.arn
    },
    {
      for region in var.replica_regions :
      region => "arn:aws:dynamodb:${region}:${split(":", aws_dynamodb_table.credentials.arn)[4]}:table/${aws_dynamodb_table.credentials.name}"
    }
  )
}

output "credentials_table_stream_arn" {
  description = "Stream ARN of the credentials table (primary region only)"
  value       = aws_dynamodb_table.credentials.stream_arn
}

# Bit indices table
output "bit_indices_table_name" {
  description = "Name of the bit_indices DynamoDB table"
  value       = aws_dynamodb_table.bit_indices.name
}

output "bit_indices_table_arns" {
  description = "Map of region to bit_indices table ARN"
  value = merge(
    {
      (data.aws_region.current.id) = aws_dynamodb_table.bit_indices.arn
    },
    {
      for region in var.replica_regions :
      region => "arn:aws:dynamodb:${region}:${split(":", aws_dynamodb_table.bit_indices.arn)[4]}:table/${aws_dynamodb_table.bit_indices.name}"
    }
  )
}

output "bit_indices_table_stream_arn" {
  description = "Stream ARN of the bit_indices table (primary region only)"
  value       = aws_dynamodb_table.bit_indices.stream_arn
}

# Legacy outputs for backwards compatibility
output "credentials_table_arn" {
  description = "ARN of the credentials DynamoDB table (primary region)"
  value       = aws_dynamodb_table.credentials.arn
}

output "bit_indices_table_arn" {
  description = "ARN of the bit_indices DynamoDB table (primary region)"
  value       = aws_dynamodb_table.bit_indices.arn
}
