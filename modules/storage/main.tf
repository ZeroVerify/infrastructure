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
