locals {
  aws_region           = "us-east-1"
  lambda_function_name = "lambdapoc"
  sqs_name             = "devops-sqs-argyle-poc"
  argyle_dlq_name      = "devops-sqs-argyle-dlq-poc"
  environment          = "test"
  owner                = "devops-poc"
}