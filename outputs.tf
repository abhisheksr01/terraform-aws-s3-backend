output "s3_backend_bucket_id" {
  description = "S3 Bucket Id for backend"
  value       = aws_s3_bucket.s3_backend_bucket.id
}

output "state_lock_dynamodb_table_id" {
  description = "Dynamo DB Table Id for backend state lock management"
  value       = aws_dynamodb_table.tf_state_locks.id
}
