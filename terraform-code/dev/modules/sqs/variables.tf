variable "aws_region" {
  description = "The AWS region"
}

variable "environment" {
  description = "The environment"
}

variable "owner" {
  description = "The owner of the application applied to the tag"
}

variable "sqs_name" {
  description = "The SQS name"
}

variable "sqs_dlq_name" {
  description = "The DLQ name"
}

variable "lambda_arn" {
  description = "The Lambda arn"
}