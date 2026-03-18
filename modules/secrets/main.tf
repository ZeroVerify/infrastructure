resource "aws_secretsmanager_secret" "baby_jubjub_private_key" {
  name        = "${var.project_name}/baby-jubjub-private-key"
  description = "Baby Jubjub EdDSA private key for credential signing"

  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "baby_jubjub_private_key" {
  secret_id = aws_secretsmanager_secret.baby_jubjub_private_key.id
  secret_string = jsonencode({
    private_key = "PLACEHOLDER_REPLACE_WITH_ACTUAL_KEY"
    description = "Baby Jubjub EdDSA private key in hex format"
  })

  lifecycle {
    ignore_changes = [secret_string]
  }
}

resource "aws_secretsmanager_secret" "hmac_key" {
  name        = "${var.project_name}/hmac-key"
  description = "HMAC key for credential verification"

  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "hmac_key" {
  secret_id = aws_secretsmanager_secret.hmac_key.id
  secret_string = jsonencode({
    hmac_key    = "PLACEHOLDER_REPLACE_WITH_ACTUAL_KEY"
    description = "HMAC key in hex format"
  })

  lifecycle {
    ignore_changes = [secret_string]
  }
}
