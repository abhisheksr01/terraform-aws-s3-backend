region              = "eu-west-2"
bucket_name         = "aws-tf-state"
dynamodb_table_name = "aws-tf-state-table"
default_tags = {
  Owner       = "Abhishek Rajput"
  Team        = "Learn"
  Environment = "Dev"
  Description = "Resources for s3 backend"
  Repository  = "https://github.com/abhisheksr01/terraform-aws-s3-backend"
  Provisioner = "Terraform"
}
