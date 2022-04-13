variable "aws_region" {
  description = "The AWS region to deploy infrastructure"
  default     = "#{codebuild.TF_VAR_REGION}"
}

variable "function_name" {
  description = "The Lambda function name"
  default     = "#{codebuild.TF_VAR_LAMBDA_FUNCTION_NAME}"
}

variable "service_type" {
  description = "The service type"
  default     = "#{codebuild.TF_VAR_SERVICE_TYPE}"
}

variable "runtime" {
  description = "Lambda runtime"
  default     = "#{codebuild.TF_VAR_LAMBDA_RUNTIME}"
}

variable "handler" {
  description = "Lambda handler"
  default     = "#{codebuild.TF_VAR_LAMBDA_HANDLER}"
}

variable "build_number" {
  description = "The build number"
  default     = "#{CODEBUILD_BUILD_NUMBER}"
}