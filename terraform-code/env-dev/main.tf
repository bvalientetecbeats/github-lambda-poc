module "apigateway" {
  source               = "../modules/apigateway"
  aws_region           = "us-west-2"
  environment          = var.environment
  owner                = "devops-tecbeats-poc"
  rest_api_domain_name = "devops-apigateway-dev"
  rest_api_name        = "api-gateway-restapi-dev"
  stage_name           = "stage_default"
  api_gtw_restapi_name = "devops-apigtw-restapi"
}

module "lambda" {
  source               = "../modules/lambda"
  aws_region           = "us-west-2"
  environment          = var.environment
  owner                = "devops-tecbeats-poc"
  lambda_function_name = "Dev-ops-Lambda-1"
  service_type         = "lambda"
  lambda_runtime       = "python3.8"
  lambda_handler       = "lambda_function.lambda_handler"
}

module "sqs" {
  source       = "../modules/sqs"
  aws_region   = "us-west-2"
  environment  = var.environment
  owner        = "devops-poc"
  sqs_name     = "devops-sqs-argyle-poc"
  sqs_dlq_name = "devops-sqs-argyle-dlq-poc"
  lambda_arn   = "arn:aws:lambda:us-west-2:416669478724:function:Dev-ops-Lambda-1"
}