terraform {
  backend "s3" {
    bucket         = "devops-terraform-state-poc-aw"
    key            = "global/${var.service_type}/terraform.tfstate"
    region         = var.aws_region
    dynamodb_table = "devops-terraform-state"
    encrypt        = false
  }
}