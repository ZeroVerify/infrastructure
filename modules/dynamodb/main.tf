resource "aws_dynamodb_table" "credentials" {
  name           = "${var.project_name}-credentials"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "subject_id"
  range_key      = "credential_id"
  stream_enabled = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = "subject_id"
    type = "S"
  }

  attribute {
    name = "credential_id"
    type = "S"
  }

  ttl {
    attribute_name = "expires_at"
    enabled        = true
  }

  replica {
    region_name = var.replica_region
  }

  tags = var.tags
}

resource "aws_dynamodb_table" "bit_indices" {
  name           = "${var.project_name}-bit-indices"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "bit_index"
  stream_enabled = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = "bit_index"
    type = "N"
  }

  replica {
    region_name = var.replica_region
  }

  tags = var.tags
}

resource "aws_dynamodb_table_item" "bit_indices_metadata" {
  table_name = aws_dynamodb_table.bit_indices.name
  hash_key   = aws_dynamodb_table.bit_indices.hash_key

  item = jsonencode({
    bit_index = { N = "-1" }
    max_index = { N = "0" }
  })

  lifecycle {
    ignore_changes = [item]
  }
}
