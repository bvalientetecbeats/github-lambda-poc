output "lambda_qualified_arn" {
  value = aws_lambda_function.lambda.qualified_arn
}

output "lambda_function_name" {
  value = aws_lambda_function.lambda.function_name
}

output "lambda_invoke_arn" {
  value = aws_lambda_function.lambda.invoke_arn
}