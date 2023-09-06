terraform {
  /* Below terraform block must be commented out when running for the first time. 🐔 🥚 */
  # backend "s3" {}

  required_version = ">= 1.5.6"
  required_providers {
    aws = ">= 5.15.0"

    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.1"
    }
  }
}

provider "aws" {
  region = var.region
}
