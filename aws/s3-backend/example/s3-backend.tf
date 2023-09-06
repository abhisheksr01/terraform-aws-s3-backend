module "s3_backend" {
  source = "../"
  #   source               = "git::https://github.com/abhisheksr01/terraform-modules.git//aws/s3-backend"
  bucket_name          = lower("${var.bucket_name}-${random_string.suffix.result}")
  dynamodb_table_name  = lower("${var.dynamodb_table_name}-${random_string.suffix.result}")
  tags                 = var.default_tags
  s3_kms_master_key_id = data.aws_kms_alias.aws_kms_s3_default_key.id
}

resource "random_string" "suffix" {
  length  = 4
  special = false
}

data "aws_kms_alias" "aws_kms_s3_default_key" {
  name = "alias/aws/s3"
}
