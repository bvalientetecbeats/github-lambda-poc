terraform {
  backend "s3" {
    bucket         = "devops-terraform-state-poc-levels"
    key            = "global/sqs/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "devops-terraform-state"
    encrypt        = false
  }
}

provider "aws" {
  region = local.aws_region
}