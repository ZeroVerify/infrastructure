output "baby_jubjub_private_key_arn" {
  description = "ARN of the Baby Jubjub private key secret"
  value       = aws_secretsmanager_secret.baby_jubjub_private_key.arn
}

output "baby_jubjub_private_key_name" {
  description = "Name of the Baby Jubjub private key secret"
  value       = aws_secretsmanager_secret.baby_jubjub_private_key.name
}

output "hmac_key_arn" {
  description = "ARN of the HMAC key secret"
  value       = aws_secretsmanager_secret.hmac_key.arn
}

output "hmac_key_name" {
  description = "Name of the HMAC key secret"
  value       = aws_secretsmanager_secret.hmac_key.name
}
