variable "aws_region" {
  description = "The AWS region to deploy infrastructure"
  default     = "${TF_REGION}"
}

variable "function_name" {
  description = "The Lambda function name"
  default     = "${TF_LAMBDA_FUNCTION_NAME}"
}

variable "service_type" {
  description = "The service type"
  default     = "${TF_SERVICE_TYPE}"  
}