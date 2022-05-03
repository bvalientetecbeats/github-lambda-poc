module "apigateway" {
  source               = "../modules/apigateway"
  aws_region           = var.aws_region
  environment          = var.environment
  owner                = var.tag_owner
  rest_api_domain_name = "devops-apigateway-dev"
  rest_api_name        = "api-gateway-restapi-dev"
  stage_name           = "stage_default"
  api_gtw_restapi_name = "devops-apigtw-restapi"
}

module "lambda" {
  source               = "../modules/lambda"
  aws_region           = var.aws_region
  environment          = var.environment
  owner                = var.tag_owner
  lambda_function_name = "lambdapoc"
  service_type         = "lambda"
  lambda_runtime       = "nodejs14.x"
  lambda_handler       = "lambda_function.lambda_handler"
}

module "sqs" {
  source       = "../modules/sqs"
  aws_region   = var.aws_region
  environment  = var.environment
  owner        = var.tag_owner
  sqs_name     = "devops-sqs-poc"
  sqs_dlq_name = "devops-sqs-dlq-poc"
  lambda_arn   = "arn:aws:lambda:us-east-1:451535584409:function:lambdapoc"
}