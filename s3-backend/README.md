# AWS S3-Backend Terraform module

Terraform module for creating a S3 backend with Dynamodb table for state locking.

## Providers

| Name                                              | Version  |
| ------------------------------------------------- | -------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=5.15.0 |

## Usage

An example of how to use this module in your terraform file.

```
module "s3_backend" {
  source               = "git::https://github.com/abhisheksr01/terraform-modules.git//aws/s3-backend"
  bucket_name          = var.bucket_name
  dynamodb_table_name  = var.dynamodb_table_name
  tags                 = var.default_tags
  s3_kms_master_key_id = data.aws_kms_alias.aws_kms_s3_default_key.id
}

data "aws_kms_alias" "aws_kms_s3_default_key" {
  name = "alias/aws/s3"
}

```

[Click here to see the detailed example implementation](./example/)

## Resources

| Name                                                                                                                                                                                        | Type     |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [aws_dynamodb_table.tf_state_locks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table)                                                             | resource |
| [aws_s3_bucket.s3_backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)                                                                           | resource |
| [aws_s3_bucket_acl.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl)                                                                      | resource |
| [aws_s3_bucket_ownership_controls.s3_backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls)                                     | resource |
| [aws_s3_bucket_server_side_encryption_configuration.s3_backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning)                                                           | resource |

## Inputs

| Name                                                                                                    | Description                              | Type                        | Default             | Required |
| ------------------------------------------------------------------------------------------------------- | ---------------------------------------- | --------------------------- | ------------------- | :------: |
| <a name="input_acl"></a> [acl](#input\_acl)                                                             | ACL Type                                 | `string`                    | `"private"`         |    no    |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name)                                   | S3 Bucket Name                           | `string`                    | n/a                 |   yes    |
| <a name="input_dynamodb_billing_mode"></a> [dynamodb\_billing\_mode](#input\_dynamodb\_billing\_mode)   | Type of Dynamo DB table billing mode     | `string`                    | `"PAY_PER_REQUEST"` |    no    |
| <a name="input_dynamodb_hash_key"></a> [dynamodb\_hash\_key](#input\_dynamodb\_hash\_key)               | Type of Dynamo DB Has Key type           | `string`                    | `"LockID"`          |    no    |
| <a name="input_dynamodb_table_name"></a> [dynamodb\_table\_name](#input\_dynamodb\_table\_name)         | Dynamo DB Table Name                     | `string`                    | n/a                 |   yes    |
| <a name="input_s3_bucket_key_enabled"></a> [s3\_bucket\_key\_enabled](#input\_s3\_bucket\_key\_enabled) | Enable sse for S3 bucket with KMS key    | `bool`                      | `true`              |    no    |
| <a name="input_s3_kms_master_key_id"></a> [s3\_kms\_master\_key\_id](#input\_s3\_kms\_master\_key\_id)  | KMS id used for encrypting the S3 bucket | `string`                    | n/a                 |   yes    |
| <a name="input_sse_algorithm"></a> [sse\_algorithm](#input\_sse\_algorithm)                             | Type of sse algorithm for encryption     | `string`                    | `"AES256"`          |    no    |
| <a name="input_tags"></a> [tags](#input\_tags)                                                          | n/a                                      | <pre>object({<br>  })</pre> | n/a                 |   yes    |

## Outputs

| Name                                                                                                                             | Description |
| -------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| <a name="output_s3_backend_bucket_id"></a> [s3\_backend\_bucket\_id](#output\_s3\_backend\_bucket\_id)                           | n/a         |
| <a name="output_state_lock_dynamodb_table_id"></a> [state\_lock\_dynamodb\_table\_id](#output\_state\_lock\_dynamodb\_table\_id) | n/a         |
<!-- END_TF_DOCS -->