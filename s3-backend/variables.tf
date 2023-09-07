variable "bucket_name" {
  description = "S3 Bucket Name"
  type        = string
}
variable "dynamodb_table_name" {
  description = "Dynamo DB Table Name"
  type        = string
}

variable "s3_bucket_public_access_block" {
  description = "S3 bucket public access block of Object type. Default set to true from security perspective."
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
}

variable "s3_bucket_logging" {
  description = "Map of S3 Bucket logging block,when set to enable = true target_bucket_name must be provided"
  type        = map(any)
  default = {
    enable            = false
    target_bucket_name = "target_bucket_name"
    target_prefix      = "/logs"
  }
}

variable "s3_bucket_object_ownership_controls" {
  description = "S3 bucket object ownership controls"
  type        = string
  default     = "BucketOwnerPreferred"
}

variable "s3_bucket_kms_master_key_id" {
  description = "KMS master key id used for encrypting the S3 bucket"
  type        = string
}

variable "s3_bucket_key_enabled" {
  description = "Enables sse for S3 bucket with KMS key"
  type        = bool
  default     = true
}

variable "s3_bucket_acl" {
  description = "S3 Buckert ACL Type"
  type        = string
  default     = "private"
}

variable "s3_bucket_sse_algorithm" {
  description = "S3 Bucket's type of sse algorithm for encryption"
  type        = string
  default     = "AES256"
}

variable "dynamodb_billing_mode" {
  description = "Type of Dynamo DB table billing mode"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "dynamodb_hash_key" {
  description = "Type of Dynamo DB Has Key type"
  type        = string
  default     = "LockID"
}

variable "dyanmodb_point_in_time_recovery" {
  description = "Enable dynamo db point in time recovery"
  type        = bool
  default     = true
}

variable "tags" {
  description = "These tags will be applied to all the resources within the module"
  type        = map(string)
}
