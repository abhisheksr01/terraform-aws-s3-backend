# AWS S3-Backend Terraform module

Terraform module for creating a S3 backend with a S3 bucket and Dynamodb table for state lock management.

The resources in the module follows the best practices and scanned by vulnerability analysis tools.

## Usage

An example of how to use this module in your terraform file.

```
module "s3_backend" {
  source                      = "abhisheksr01/s3-backend/aws"
  version                     = "0.1.0"
  bucket_name                 = var.bucket_name
  dynamodb_table_name         = var.dynamodb_table_name
  tags                        = var.default_tags
  s3_bucket_kms_master_key_id = data.aws_kms_alias.aws_kms_s3_default_key.id
}

data "aws_kms_alias" "aws_kms_s3_default_key" {
  name = "alias/aws/s3"
}
```

[Click here to see simplest implementation example and relevant details](https://github.com/abhisheksr01/terraform-aws-s3-backend/tree/main/example/basic)
<!-- BEGIN_TF_DOCS -->


## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.tf_state_locks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_s3_bucket.s3_backend_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.s3_backend_acl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_logging.s3_backend_bucket_logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_logging) | resource |
| [aws_s3_bucket_ownership_controls.s3_backend_ownership](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_public_access_block.s3_backend_public_access_block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.s3_backend_sse_config](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.s3_backend_versioning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | S3 Bucket Name | `string` | n/a | yes |
| <a name="input_dyanmodb_point_in_time_recovery"></a> [dyanmodb\_point\_in\_time\_recovery](#input\_dyanmodb\_point\_in\_time\_recovery) | Enable dynamo db point in time recovery | `bool` | `true` | no |
| <a name="input_dynamodb_billing_mode"></a> [dynamodb\_billing\_mode](#input\_dynamodb\_billing\_mode) | Type of Dynamo DB table billing mode | `string` | `"PAY_PER_REQUEST"` | no |
| <a name="input_dynamodb_hash_key"></a> [dynamodb\_hash\_key](#input\_dynamodb\_hash\_key) | Type of Dynamo DB Has Key type | `string` | `"LockID"` | no |
| <a name="input_dynamodb_table_name"></a> [dynamodb\_table\_name](#input\_dynamodb\_table\_name) | Dynamo DB Table Name | `string` | n/a | yes |
| <a name="input_s3_bucket_acl"></a> [s3\_bucket\_acl](#input\_s3\_bucket\_acl) | S3 Buckert ACL Type | `string` | `"private"` | no |
| <a name="input_s3_bucket_key_enabled"></a> [s3\_bucket\_key\_enabled](#input\_s3\_bucket\_key\_enabled) | Enables sse for S3 bucket with KMS key | `bool` | `true` | no |
| <a name="input_s3_bucket_kms_master_key_id"></a> [s3\_bucket\_kms\_master\_key\_id](#input\_s3\_bucket\_kms\_master\_key\_id) | KMS master key id used for encrypting the S3 bucket | `string` | n/a | yes |
| <a name="input_s3_bucket_logging"></a> [s3\_bucket\_logging](#input\_s3\_bucket\_logging) | Map of S3 Bucket logging block,when set to enable = true target\_bucket\_name must be provided | `map(any)` | <pre>{<br>  "enable": false,<br>  "target_bucket_name": "target_bucket_name",<br>  "target_prefix": "/logs"<br>}</pre> | no |
| <a name="input_s3_bucket_object_ownership_controls"></a> [s3\_bucket\_object\_ownership\_controls](#input\_s3\_bucket\_object\_ownership\_controls) | S3 bucket object ownership controls | `string` | `"BucketOwnerPreferred"` | no |
| <a name="input_s3_bucket_public_access_block"></a> [s3\_bucket\_public\_access\_block](#input\_s3\_bucket\_public\_access\_block) | S3 bucket public access block of Object type. Default set to true from security perspective. | <pre>object({<br>    block_public_acls       = bool<br>    block_public_policy     = bool<br>    ignore_public_acls      = bool<br>    restrict_public_buckets = bool<br>  })</pre> | <pre>{<br>  "block_public_acls": true,<br>  "block_public_policy": true,<br>  "ignore_public_acls": true,<br>  "restrict_public_buckets": true<br>}</pre> | no |
| <a name="input_s3_bucket_sse_algorithm"></a> [s3\_bucket\_sse\_algorithm](#input\_s3\_bucket\_sse\_algorithm) | S3 Bucket's type of sse algorithm for encryption | `string` | `"AES256"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | These tags will be applied to all the resources within the module | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_s3_backend_bucket_id"></a> [s3\_backend\_bucket\_id](#output\_s3\_backend\_bucket\_id) | S3 Bucket Id for backend |
| <a name="output_state_lock_dynamodb_table_id"></a> [state\_lock\_dynamodb\_table\_id](#output\_state\_lock\_dynamodb\_table\_id) | Dynamo DB Table Id for backend state lock management |
<!-- END_TF_DOCS -->