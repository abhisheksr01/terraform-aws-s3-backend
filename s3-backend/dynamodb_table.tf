resource "aws_dynamodb_table" "tf_state_locks" {
  depends_on   = [aws_s3_bucket.s3_backend]
  name         = var.dynamodb_table_name
  billing_mode = var.dynamodb_billing_mode
  hash_key     = var.dynamodb_hash_key
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = var.tags
}
