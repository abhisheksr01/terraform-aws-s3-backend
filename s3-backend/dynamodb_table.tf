resource "aws_dynamodb_table" "tf_state_locks" {
  depends_on   = [aws_s3_bucket.s3_backend_bucket]
  name         = var.dynamodb_table_name
  billing_mode = var.dynamodb_billing_mode
  hash_key     = var.dynamodb_hash_key
  attribute {
    name = "LockID"
    type = "S"
  }
  server_side_encryption {
    enabled = true // This must be enabled by default for security perspective
  }
  tags = var.tags

  point_in_time_recovery {
    enabled = var.dyanmodb_point_in_time_recovery
  }
}
