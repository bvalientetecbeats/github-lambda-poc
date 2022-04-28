locals {
  aws_region           = "us-east-1"
  lambda_function_name = "lambdapoc"
  service_type         = "lambda"
  lambda_runtime       = "python3.8"
  lambda_handler       = "lambda_function.lambda_handler"
}