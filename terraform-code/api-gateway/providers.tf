terraform {
  required_version = ">= 0.12"
    
  backend "s3" {
    bucket         = "devops-terraform-state-poc-levelgoals"
    key            = "global/api_gateway/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "devops-terraform-state"
    encrypt        = false
  }
}

provider "aws" {
  region = local.aws_region
}