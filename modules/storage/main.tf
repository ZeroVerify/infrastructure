resource "aws_s3_bucket" "deployment_artifacts" {
  bucket = "${var.project_name}-deployment-artifacts"

  tags = var.tags
}

resource "aws_s3_bucket_lifecycle_configuration" "deployment_artifacts" {
  bucket = aws_s3_bucket.deployment_artifacts.id

  rule {
    id     = "abort-incomplete-uploads"
    status = "Enabled"

    filter {}

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}

resource "aws_s3_bucket_public_access_block" "deployment_artifacts" {
  bucket = aws_s3_bucket.deployment_artifacts.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "archive_file" "issuer_stub" {
  type        = "zip"
  output_path = "${path.module}/.terraform/issuer-stub.zip"

  source {
    content  = "Stub - will be updated by GitHub Actions"
    filename = "stub.txt"
  }
}

data "archive_file" "revocation_stub" {
  type        = "zip"
  output_path = "${path.module}/.terraform/revocation-stub.zip"

  source {
    content  = "Stub - will be updated by GitHub Actions"
    filename = "stub.txt"
  }
}

data "archive_file" "free_stub" {
  type        = "zip"
  output_path = "${path.module}/.terraform/free-stub.zip"

  source {
    content  = "Stub - will be updated by GitHub Actions"
    filename = "stub.txt"
  }
}

data "archive_file" "bitstring_updater_stub" {
  type        = "zip"
  output_path = "${path.module}/.terraform/bitstring-updater-stub.zip"

  source {
    content  = "Stub - will be updated by GitHub Actions"
    filename = "stub.txt"
  }
}

# Upload stub artifacts to S3
resource "aws_s3_object" "issuer_stub" {
  bucket = aws_s3_bucket.deployment_artifacts.id
  key    = "lambda/issuer-lambda.zip"
  source = data.archive_file.issuer_stub.output_path
  etag   = data.archive_file.issuer_stub.output_md5

  lifecycle {
    ignore_changes = [etag, source, source_hash]
  }
}

resource "aws_s3_object" "revocation_stub" {
  bucket = aws_s3_bucket.deployment_artifacts.id
  key    = "lambda/revocation-lambda.zip"
  source = data.archive_file.revocation_stub.output_path
  etag   = data.archive_file.revocation_stub.output_md5

  lifecycle {
    ignore_changes = [etag, source, source_hash]
  }
}

resource "aws_s3_object" "free_stub" {
  bucket = aws_s3_bucket.deployment_artifacts.id
  key    = "lambda/free-lambda.zip"
  source = data.archive_file.free_stub.output_path
  etag   = data.archive_file.free_stub.output_md5

  lifecycle {
    ignore_changes = [etag, source, source_hash]
  }
}

resource "aws_s3_object" "bitstring_updater_stub" {
  bucket = aws_s3_bucket.deployment_artifacts.id
  key    = "lambda/bitstring-updater-lambda.zip"
  source = data.archive_file.bitstring_updater_stub.output_path
  etag   = data.archive_file.bitstring_updater_stub.output_md5

  lifecycle {
    ignore_changes = [etag, source, source_hash]
  }
}

# Public artifacts bucket for circuits, keys, and bitstring
resource "aws_s3_bucket" "artifacts" {
  bucket = "${var.project_name}-artifacts"

  tags = var.tags
}

# Enable public read access for artifacts bucket
resource "aws_s3_bucket_public_access_block" "artifacts" {
  bucket = aws_s3_bucket.artifacts.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Bucket policy to allow public read
resource "aws_s3_bucket_policy" "artifacts" {
  bucket = aws_s3_bucket.artifacts.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.artifacts.arn}/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.artifacts]
}

# CORS configuration for browser access
resource "aws_s3_bucket_cors_configuration" "artifacts" {
  bucket = aws_s3_bucket.artifacts.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3600
  }
}

# Versioning for artifacts bucket
resource "aws_s3_bucket_versioning" "artifacts" {
  bucket = aws_s3_bucket.artifacts.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Lifecycle policy for old versions
resource "aws_s3_bucket_lifecycle_configuration" "artifacts" {
  bucket = aws_s3_bucket.artifacts.id

  rule {
    id     = "expire-old-versions"
    status = "Enabled"

    filter {}

    noncurrent_version_expiration {
      noncurrent_days = 30
    }
  }

  rule {
    id     = "abort-incomplete-uploads"
    status = "Enabled"

    filter {}

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}
