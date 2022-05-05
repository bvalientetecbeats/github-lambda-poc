variable "aws_region" {
  description = "The AWS region"
}

variable "environment" {
  description = "The environment"
}

variable "owner" {
  description = "The owner of the application applied to the tag"
}

variable "api_gtw_restapi_name" {
  description = "The API Gateway name"

}

variable "rest_api_domain_name" {
  description = "The API Gateway rest api domain name"
}

variable "rest_api_name" {
  description = "The rest api name"
}

variable "stage_name" {
  description = "The API Gateway stage name"
}

variable "lambda_arn_action" {
  description = "The Lambda ARN"
}