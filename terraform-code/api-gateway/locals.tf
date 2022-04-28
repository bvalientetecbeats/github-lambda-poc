locals {
  aws_region = "us-west-2"
  service_type = "lambda"
  lambda_runtime = "python3.8"
  lambda_handler = "lambda_function.lambda_handler"
  rest_api_domain_name = "example.com"
  rest_api_name        = "api-gateway-rest-api-openapi-example"
  rest_api_path        = "/path1"
}