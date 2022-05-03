terraform {
  required_version = ">= 0.12"

  backend "s3" {
    bucket         = "devops-terraform-state-poc-levels"
    key            = "global/api_gateway/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "devops-terraform-state"
    encrypt        = false
  }
}

provider "aws" {
  region = var.aws_region
}