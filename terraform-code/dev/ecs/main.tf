module "apigateway" {
  source               = "./modules/apigateway"
  aws_region           = var.aws_region
  environment          = var.environment
  owner                = var.tag_owner
  rest_api_domain_name = "devops-apigateway-dev.dev"
  rest_api_name        = "devops-restapi-dev"
  stage_name           = "stage_default"
  api_gtw_restapi_name = "devops-apigtw-dev"
  lambda_arn_action    = "arn:aws:lambda:us-west-2:416669478724:function:devops-lambda-dev/invocations"
}

#module "lambda" {
#  source               = "./modules/lambda"
#  aws_region           = var.aws_region
#  environment          = var.environment
#  owner                = var.tag_owner
#  lambda_function_name = "devops-lambda-dev"
#  service_type         = "lambda"
#  lambda_runtime       = "nodejs14.x"
#  lambda_handler       = "lambda_function.lambda_handler"
#}

module "sqs" {
  source       = "./modules/sqs"
  aws_region   = var.aws_region
  environment  = var.environment
  owner        = var.tag_owner
  sqs_name     = "devops-sqs-poc"
  sqs_dlq_name = "devops-sqs-dlq-poc"
  lambda_arn   = "arn:aws:lambda:us-west-2:416669478724:function:devops-lambda-dev"
}