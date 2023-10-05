output "s3_backend_bucket_id" {
  value = module.s3_backend.s3_backend_bucket_id
}

output "state_lock_dynamodb_table_id" {
  value = module.s3_backend.state_lock_dynamodb_table_id
}
