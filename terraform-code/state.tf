terraform {
  backend "s3" {
    bucket         = "devops-terraform-state-poc-levelsgoals"
    key            = "global/lambda/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "devops-terraform-state"
    encrypt        = false
  }
}