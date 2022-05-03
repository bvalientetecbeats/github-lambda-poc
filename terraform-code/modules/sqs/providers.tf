terraform {
  backend "s3" {
    bucket         = "devops-terraform-state-poc-levelgoals"
    key            = "global/sqs/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "devops-terraform-state"
    encrypt        = false
  }
}

provider "aws" {
  region = var.aws_region
}