variable "remote_backend_name" {}

variable "environment_name" {}

variable "owner" {}

variable "description" {}
variable "s3_kms_master_key_id" {
  description = "KMS id used for encrypting the S3 bucket"
  type        = string
}

variable "acl" {
  default = "private"
}

variable "enable_versioning" {
  default = true
}

variable "sse_algorithm" {
  default = "AES256"
}

variable "dynamodb_billing_mode" {
  default = "PAY_PER_REQUEST"
}

variable "dynamodb_hash_key" {
  default = "LockID"
}

variable "additional_tags" {
  default     = {}
  description = "Additional resource tags"
  type        = map(string)
}

variable "s3_bucket_key_enabled" {
  default     = true
  description = "Enable S3 bucket for KMS key"
  type        = bool
}