data "aws_region" "current" {}

resource "aws_lambda_function" "issuer" {
  function_name = "${var.project_name}-issuer"
  role          = var.issuer_lambda_role_arn
  handler       = "bootstrap"
  runtime       = "provided.al2023"
  architectures = ["arm64"]

  s3_bucket = var.deployment_artifacts_bucket[var.primary_region]
  s3_key    = "lambda/issuer-lambda.zip"

  memory_size = 512
  timeout     = 30

  environment {
    variables = {
      KEYCLOAK_TOKEN_URL         = "https://keycloak.zeroverify.net/realms/zeroverify/protocol/openid-connect/token"
      KEYCLOAK_CLIENT_ID         = "zeroverify-wallet"
      OAUTH_REDIRECT_URI         = "https://wallet.zeroverify.net/callback"
      ISSUER_DID                 = "did:web:api.zeroverify.net"
      PRIMARY_REGION             = var.primary_region
      SECRET_NAME_HMAC_KEY       = var.secret_name_hmac_key
      SECRET_NAME_EDDSA_KEY      = var.secret_name_eddsa_key
      DYNAMODB_CREDENTIALS_TABLE = var.credentials_table_name
      DYNAMODB_BIT_INDICES_TABLE = var.bit_indices_table_name
    }
  }

  lifecycle {
    ignore_changes = [
      source_code_hash
    ]
  }

  tags = var.tags
}

resource "aws_lambda_function" "issuer_replica" {
  for_each = toset(var.replica_regions)

  region        = each.value
  function_name = "${var.project_name}-issuer"
  role          = var.issuer_lambda_role_arn
  handler       = "bootstrap"
  runtime       = "provided.al2023"
  architectures = ["arm64"]

  s3_bucket = var.deployment_artifacts_bucket[each.value]
  s3_key    = "lambda/issuer-lambda.zip"

  memory_size = 512
  timeout     = 30

  environment {
    variables = {
      KEYCLOAK_TOKEN_URL         = "https://keycloak.zeroverify.net/realms/zeroverify/protocol/openid-connect/token"
      KEYCLOAK_CLIENT_ID         = "zeroverify-wallet"
      OAUTH_REDIRECT_URI         = "https://wallet.zeroverify.net/callback"
      ISSUER_DID                 = "did:web:api.zeroverify.net"
      PRIMARY_REGION             = var.primary_region
      SECRET_NAME_HMAC_KEY       = var.secret_name_hmac_key
      SECRET_NAME_EDDSA_KEY      = var.secret_name_eddsa_key
      DYNAMODB_CREDENTIALS_TABLE = var.credentials_table_name
      DYNAMODB_BIT_INDICES_TABLE = var.bit_indices_table_name
    }
  }

  lifecycle {
    ignore_changes = [
      source_code_hash
    ]
  }

  tags = var.tags
}

resource "aws_lambda_function" "revocation" {
  function_name = "${var.project_name}-revocation"
  role          = var.revocation_lambda_role_arn
  handler       = "bootstrap"
  runtime       = "provided.al2023"
  architectures = ["arm64"]

  s3_bucket = var.deployment_artifacts_bucket[var.primary_region]
  s3_key    = "lambda/revocation-lambda.zip"

  memory_size = 256
  timeout     = 15

  environment {
    variables = {
      ENVIRONMENT            = "production"
      PRIMARY_REGION         = var.primary_region
      CREDENTIALS_TABLE_NAME = var.credentials_table_name
      BIT_INDICES_TABLE_NAME = var.bit_indices_table_name
    }
  }

  lifecycle {
    ignore_changes = [
      source_code_hash
    ]
  }

  tags = var.tags
}

resource "aws_lambda_function" "revocation_replica" {
  for_each = toset(var.replica_regions)

  region        = each.value
  function_name = "${var.project_name}-revocation"
  role          = var.revocation_lambda_role_arn
  handler       = "bootstrap"
  runtime       = "provided.al2023"
  architectures = ["arm64"]

  s3_bucket = var.deployment_artifacts_bucket[each.value]
  s3_key    = "lambda/revocation-lambda.zip"

  memory_size = 256
  timeout     = 15

  environment {
    variables = {
      ENVIRONMENT            = "production"
      PRIMARY_REGION         = var.primary_region
      CREDENTIALS_TABLE_NAME = var.credentials_table_name
      BIT_INDICES_TABLE_NAME = var.bit_indices_table_name
    }
  }

  lifecycle {
    ignore_changes = [
      source_code_hash
    ]
  }

  tags = var.tags
}

resource "aws_lambda_function" "free" {
  function_name = "${var.project_name}-free"
  role          = var.free_lambda_role_arn
  handler       = "bootstrap"
  runtime       = "provided.al2023"
  architectures = ["arm64"]

  s3_bucket = var.deployment_artifacts_bucket[var.primary_region]
  s3_key    = "lambda/free-lambda.zip"

  memory_size = 256
  timeout     = 15

  environment {
    variables = {
      ENVIRONMENT            = "production"
      PRIMARY_REGION         = var.primary_region
      CREDENTIALS_TABLE_NAME = var.credentials_table_name
      BIT_INDICES_TABLE_NAME = var.bit_indices_table_name
    }
  }

  lifecycle {
    ignore_changes = [
      source_code_hash
    ]
  }

  tags = var.tags
}

resource "aws_lambda_function" "bitstring_updater" {
  function_name = "${var.project_name}-bitstring-updater"
  role          = var.bitstring_updater_lambda_role_arn
  handler       = "bootstrap"
  runtime       = "provided.al2023"
  architectures = ["arm64"]

  s3_bucket = var.deployment_artifacts_bucket[var.primary_region]
  s3_key    = "lambda/bitstring-updater-lambda.zip"

  memory_size = 512
  timeout     = 60

  environment {
    variables = {
      ENVIRONMENT            = "production"
      PRIMARY_REGION         = var.primary_region
      CREDENTIALS_TABLE_NAME = var.credentials_table_name
      BIT_INDICES_TABLE_NAME = var.bit_indices_table_name
      ARTIFACTS_BUCKET_NAME  = var.artifacts_bucket_name
    }
  }

  lifecycle {
    ignore_changes = [
      source_code_hash
    ]
  }

  tags = var.tags
}

resource "aws_lambda_event_source_mapping" "bitstring_updater" {
  event_source_arn  = var.bit_indices_table_stream_arn
  function_name     = aws_lambda_function.bitstring_updater.arn
  starting_position = "LATEST"
  batch_size        = 100

  filter_criteria {
    filter {
      pattern = jsonencode({
        eventName = ["INSERT", "MODIFY", "REMOVE"]
      })
    }
  }
}

resource "aws_lambda_event_source_mapping" "free" {
  event_source_arn  = var.credentials_table_stream_arn
  function_name     = aws_lambda_function.free.arn
  starting_position = "LATEST"
  batch_size        = 100

  filter_criteria {
    filter {
      pattern = jsonencode({
        eventName = ["MODIFY", "REMOVE"]
      })
    }
  }
}
