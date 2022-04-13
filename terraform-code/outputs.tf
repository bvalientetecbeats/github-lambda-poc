output "lambda" {
  value = "${aws_lambda_function.lambda.qualified_arn}"
}

output "service_type" {
  value = var.service_type
}

output "lambda_function_name" { 
  value = var.lambda_function_name  
}

output "lambda_handler" {
  value = var.lambda_handler
}