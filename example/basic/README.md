# Introduction

This directory contains simplest example of how to use the module with default values ideal for s3-backend.


# **Chicken and Egg Paradox**

Building infrastructure from scratch poses a "Chicken and Egg Paradox" challenge.
This challenge arises because, for Terraform to store its state, a storage is required (in case of AWS its S3). We may choose to provision this storage manually.
However, as per our commitment to provisioning all resources through Infrastructure as Code (IAC), we encounter a problem.

This module provides an opinionated means of dealing with the above problem statement.

# Implementation

- Authenticate AWS CLI.
- Add AWS Provider in the Terraform Provider block.
  ```terraform
  terraform {
    # backend "s3" {}

    required_version = ">= 1.5.7"
    required_providers {
      aws = ">= 5.15.0"

      random = {
        source  = "hashicorp/random"
        version = "~> 3.5.1"
      }
    }
  }
  ```
- Initialize Terraform without a `backend "s3" {}` remote backend.
  ```bash
  terraform init
  ```
- Add the `abhisheksr01/s3-backend/aws` module and pass on required variables in your TF codebase.
  ```terraform
  module "s3_backend" {
    source                      = "abhisheksr01/s3-backend/aws"
    version                     = "0.1.0"
    bucket_name                 = lower("${var.bucket_name}-${random_string.suffix.result}")
    dynamodb_table_name         = lower("${var.dynamodb_table_name}-${random_string.suffix.result}")
    tags                        = var.default_tags
    s3_bucket_kms_master_key_id = data.aws_kms_alias.aws_kms_s3_default_key.id
  }

  resource "random_string" "suffix" {
    length  = 4
    special = false
  }

  data "aws_kms_alias" "aws_kms_s3_default_key" {
    name = "alias/aws/s3"
  }
  ```
- Plan Terraform changes to review what resources module will create.
  ```bash
  terraform plan
  ```
- Apply Terraform changes to create the s3-backend successfully.
    ```bash
  terraform apply
  ```
- After the s3-backend is provisioned, add the Terraform backend configuration `backend "s3" {}` and populate it with newly created `s3-backend` configuration.
  ```terraform
  backend "s3" {
    bucket         = "aws-tf-state"
    key            = "s3/backend-state/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "aws-tf-state-table"
  }
  ```
  or populate them in the [backend-config.hcl](./backend-config.hcl) as we did in the example.
- Subsequently, Reinitialize Terraform to migrate tfstate to the newly created remote s3-backend. When prompted to confirm the migration type `yes` and enter.
  ```bash
  terraform init -backend-config=backend-config.hcl
  ```
- Now, the backend provisioning is managed by Terraform itself, ensuring ease of management when you would like to tweak it for any reason.