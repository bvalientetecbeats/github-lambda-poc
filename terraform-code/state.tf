terraform {
  backend "s3" {
    bucket         = "devops-terraform-state-poc-aw"
    key            = "global/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "devops-terraform-state"
    encrypt        = false
  }
}