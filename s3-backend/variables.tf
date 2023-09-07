variable "bucket_name" {
  type        = string
  description = "S3 Bucket Name"
}
variable "dynamodb_table_name" {
  type        = string
  description = "Dynamo DB Table Name"
}

variable "s3_bucket_public_access_block" {
  type = object({
    block_public_acls       = bool
    block_public_policy     = bool
    ignore_public_acls      = bool
    restrict_public_buckets = bool
  })
  default = {
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }
  description = "S3 bucket public access block values. Default set to true from security perspective."
}

variable "s3_bucket_object_ownership_controls" {
  default     = "BucketOwnerPreferred"
  description = "value"
}

variable "s3_bucket_kms_master_key_id" {
  description = "KMS master key id used for encrypting the S3 bucket"
  type        = string
}

variable "s3_bucket_key_enabled" {
  default     = true
  description = "Whether to enable sse for S3 bucket with KMS key"
  type        = bool
}

variable "s3_bucket_acl" {
  description = "S3 Buckert ACL Type"
  default     = "private"
}

variable "s3_bucket_sse_algorithm" {
  description = "S3 Bucket's type of sse algorithm for encryption"
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

variable "dyanmodb_point_in_time_recovery" {
  type        = bool
  description = "Enable dynamo db point in time recovery"
  default     = true
}

variable "tags" {
  description = "These tags will be applied to all the resources within the module"
  type = object({
  })
}
