locals {
  bucket_name = "s3-app-lambda"
  bucket_acl  = "private"
  environment = "prod"
  versioning_enabled = true
}
resource "aws_s3_bucket" "bucket_lambda" {
  bucket = local.bucket_name
  acl    = local.bucket_acl

  tags = {
    Name        = local.bucket_name
    Environment = local.environment
  }
}

resource "aws_s3_bucket_versioning" "versioning_bucked_lambda" {
  bucket = aws_s3_bucket.bucket_lambda.id
  versioning_configuration {
    status = var.versioning_enabled ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access_bucket_lambda" {
  bucket = aws_s3_bucket.bucket_lambda.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
