variable "aws_region" {
  description = "The AWS region to use"
  default = "us-west-2"  
}

variable "lambda_function_name" {
  description = "The name of the Lambda function"
}

variable "service_type" {
  description = "The type of service to create"
}

variable "lambda_runtime" {
  description = "The runtime to use for the Lambda function"
}

variable "lambda_handler" {
  description = "The handler to use for the Lambda function"  
}

variable "CODEBUILD_BUILD_NUMBER" {
  description = "The build number of the current build"
}