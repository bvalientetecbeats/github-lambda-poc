variable "aws_region" {
  description = "The AWS region to deploy infrastructure"
  default     = "#{TF_VAR_REGION}"
  type        = "string"
}

variable "function_name" {
  description = "The Lambda function name"
  default     = "#{TF_VAR_LAMBDA_FUNCTION_NAME}"
  type        = "string"
}

variable "service_type" {
  description = "The service type"
  default     = "#{TF_VAR_SERVICE_TYPE}"
  type        = "string"
}

variable "runtime" {
  description = "Lambda runtime"
  default     = "#{TF_VAR_LAMBDA_RUNTIME}"
  type        = "string"
}

variable "handler" {
  description = "Lambda handler"
  default     = "#{TF_VAR_LAMBDA_HANDLER}"
  type        = "string"
}

variable "build_number" {
  description = "The build number"
  default     = "#{CODEBUILD_BUILD_NUMBER}"
  type        = "number"
}