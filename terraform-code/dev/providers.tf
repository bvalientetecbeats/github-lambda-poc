provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket         = "devops-terraform-state-levelgoals-dev"
    key            = "global/dev/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "devops-terraform-state"
    encrypt        = false
  }
}