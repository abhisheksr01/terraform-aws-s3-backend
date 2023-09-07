resource "aws_s3_bucket" "s3_backend_bucket" {
  bucket   = var.bucket_name
  tags_all = var.tags
}

resource "aws_s3_bucket_public_access_block" "s3_backend_public_access_block" {
  bucket                  = aws_s3_bucket.s3_backend_bucket.id
  block_public_acls       = var.s3_bucket_public_access_block.block_public_acls
  block_public_policy     = var.s3_bucket_public_access_block.block_public_policy
  ignore_public_acls      = var.s3_bucket_public_access_block.ignore_public_acls
  restrict_public_buckets = var.s3_bucket_public_access_block.restrict_public_buckets
}

resource "aws_s3_bucket_ownership_controls" "s3_backend_ownership" {
  bucket = aws_s3_bucket.s3_backend_bucket.id
  rule {
    object_ownership = var.s3_bucket_object_ownership_controls
  }
}

resource "aws_s3_bucket_acl" "s3_backend_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.s3_backend_ownership]
  bucket     = aws_s3_bucket.s3_backend_bucket.id
  acl        = var.s3_bucket_acl
}

resource "aws_s3_bucket_versioning" "s3_backend_versioning" {
  bucket = aws_s3_bucket.s3_backend_bucket.id
  versioning_configuration {
    status = "Enabled" // This must be enabled by default for optimal usage of s3 bucket as backend
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_backend_sse_config" {
  bucket = aws_s3_bucket.s3_backend_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.s3_bucket_kms_master_key_id
      sse_algorithm     = "aws:kms"
    }
    bucket_key_enabled = var.s3_bucket_key_enabled
  }
}
