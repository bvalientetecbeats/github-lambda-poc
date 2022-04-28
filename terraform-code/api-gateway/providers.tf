terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = local.aws_region
}

terraform {
  backend "s3" {
    bucket         = "devops-terraform-state-poc-levelgoals"
    key            = "global/api_gateway/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "devops-terraform-state"
    encrypt        = false
  }
}