provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket         = "devops-terraform-state-poc-levels"
    key            = "global/qa/ecs/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "devops-terraform-state"
    encrypt        = false
  }
}