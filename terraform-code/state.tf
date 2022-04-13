terraform {
  backend "s3" {
    bucket         = "${state_bucket}"
    key            = "global/lambda/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "devops-terraform-state"
    encrypt        = false
  }
}