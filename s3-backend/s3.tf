resource "aws_s3_bucket" "s3_backend" {
  bucket = var.bucket_name
  tags   = var.tags
}

resource "aws_s3_bucket_ownership_controls" "s3_backend" {
  bucket = aws_s3_bucket.s3_backend.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [aws_s3_bucket_ownership_controls.s3_backend]
  bucket     = aws_s3_bucket.s3_backend.id
  acl        = "private"
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.s3_backend.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_backend" {
  bucket = aws_s3_bucket.s3_backend.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.s3_kms_master_key_id
      sse_algorithm     = "aws:kms"
    }
    bucket_key_enabled = var.s3_bucket_key_enabled
  }
}
