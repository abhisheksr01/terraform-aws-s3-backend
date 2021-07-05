output "s3_backend_arn" {
  value = aws_s3_bucket.s3_backend.arn
}

output "s3_backend_bucket_id" {
  value = aws_s3_bucket.s3_backend.id
}

output "state_lock_dynamodb_table_arn" {
  value = aws_dynamodb_table.tf_state_locks.arn
}
