#provider "aws" {
#  region = var.aws_region
#}

#terraform {
#  required_version = ">= 0.12"

#  backend "s3" {
#    bucket         = "devops-terraform-state-levelgoals-dev"
#    key            = "global/dev/api_gateway/terraform.tfstate"
#    region         = "us-west-2"
#    dynamodb_table = "devops-terraform-state"
#    encrypt        = false
#  }
#}