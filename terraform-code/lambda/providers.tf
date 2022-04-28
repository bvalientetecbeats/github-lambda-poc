provider "aws" {
  region = local.aws_region
}

terraform {
  backend "s3" {
    bucket         = "devops-terraform-state-poc-levelgoals"
    key            = "global/lambda/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "devops-terraform-state"
    encrypt        = false
  }
}