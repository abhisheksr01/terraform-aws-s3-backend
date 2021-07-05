resource "aws_s3_bucket" "s3_backend" {
  bucket = var.remote_backend_name
  acl    = var.acl

  versioning {
    enabled = var.enable_versioning
  }

  tags = merge(
    var.additional_tags,
    {
      Terraform   = true
      Owner       = var.owner
      Environment = var.environment_name
      Description = var.description
    }
  )

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = var.s3_kms_master_key_id
        sse_algorithm     = "aws:kms"
      }
      bucket_key_enabled = var.s3_bucket_key_enabled
    }
  }
}

resource "aws_dynamodb_table" "tf_state_locks" {
  name         = var.remote_backend_name
  billing_mode = var.dynamodb_billing_mode
  hash_key     = var.dynamodb_hash_key

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = merge(
    var.additional_tags,
    {
      Terraform   = true
      Owner       = var.owner
      Environment = var.environment_name
      Description = var.description
    },
  )
}