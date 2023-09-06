variable "bucket_name" {
  type        = string
  description = "S3 Bucket Name"
}
variable "dynamodb_table_name" {
  type        = string
  description = "Dynamo DB Table Name"
}

variable "s3_kms_master_key_id" {
  description = "KMS id used for encrypting the S3 bucket"
  type        = string
}

variable "acl" {
  description = "ACL Type"
  default     = "private"
}

variable "sse_algorithm" {
  description = "Type of sse algorithm for encryption"
  default     = "AES256"
}

variable "dynamodb_billing_mode" {
  description = "Type of Dynamo DB table billing mode"
  default     = "PAY_PER_REQUEST"
}

variable "dynamodb_hash_key" {
  description = "Type of Dynamo DB Has Key type"
  default     = "LockID"
}

variable "s3_bucket_key_enabled" {
  default     = true
  description = "Enable sse for S3 bucket with KMS key"
  type        = bool
}

variable "tags" {
  type = object({
  })
}
