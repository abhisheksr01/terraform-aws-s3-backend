variable "bucket_name" {
  type        = string
  description = "S3 bucket_name"
}

variable "dynamodb_table_name" {
  type        = string
  description = "S3 dynamo db table name"
}

variable "region" {
  type        = string
  description = "AWS Region"
}

variable "default_tags" {
  type = object({
    Owner       = string
    Team        = string
    Environment = string
    Description = string
    Repository  = string
    Provisioner = string
  })
}
