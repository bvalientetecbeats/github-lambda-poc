variable "aws_region" {
  description = "The AWS region to deploy infrastructure"
  default     = "#{codebuild.TF_REGION}"
}

variable "function_name" {
  description = "The Lambda function name"
  default     = "#{codebuild.TF_LAMBDA_FUNCTION_NAME}"
}

variable "service_type" {
  description = "The service type"
  default     = "#{codebuild.TF_SERVICE_TYPE}"
}