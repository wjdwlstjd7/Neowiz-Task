# AWS resource
provider "aws" {
  region = "ap-northeast-2"
  version = ">= 5.0"
  shared_credentials_files = ["~/.aws/credentials"]
  profile = "histdc-dev"
}

# Terraform Version
terraform {
  required_version = ">= 1.6.3"
}