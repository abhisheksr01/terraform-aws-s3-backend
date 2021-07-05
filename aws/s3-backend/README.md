# AWS S3-Backend Terraform module

Terraform module for creating a S3 backend with Dynamodb table for state locking.

## Terraform versions
Terraform 1.0.1 and newer.

## Usage

This s3-backend module will create a S3 bucket & dynamodb table with same name as specified by the variable **remote_backend_name**.

An example of how to use this module in your terraform file.

```
module "s3_backend" {
  source = "git::https://github.com/abhisheksr01/terraform-modules.git//aws/s3-backend"

  remote_backend_name      = "tf-integration-env-state"
  environment_name         = "integration"
  s3_kms_master_key_id     = data.aws_kms_alias.aws_kms_s3_default_key.id
}

data "aws_kms_alias" "aws_kms_s3_default_key" {
  name = "alias/aws/s3"
}
```

The default behavior can be changed by updating below variables values in a tfvars file:

| Variable Name                     | Type          |      Default Value                                  | Required |
|-----------------------------------|:--------------|:----------------------------------------------------|:---------|
| remote_backend_name               | string        | -                                                   | yes      |
| environment_name                  | string        | -                                                   | yes      |
| description                       | string        | -                                                   | yes      |
| s3_kms_master_key_id              | string        | -                                                   | yes      |
| s3_bucket_key_enabled             | bool          | true                                                 | no      |
| owner                             | string        |                                                   | no       |
| acl                               | string        | private                                             | no       |
| enable_versioning                 | bool          | true                                                | no       |
| sse_algorithm                     | string        | AES256                                              | no       |
| dynamodb_billing_mode             | string        | PAY_PER_REQUEST                                     | no       |  
| dynamodb_hash_key                 | string        | LockID                                              | no       |
| additional_tags                   | map(string)   | -                                                   | no       |
</br>

To learn more about individual variables click [here.](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)