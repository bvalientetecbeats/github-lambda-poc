resource "aws_sqs_queue" "argyle_queue" {
  name                      = local.sqs_name
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.terraform_queue_deadletter.arn
    maxReceiveCount     = 4
  })
  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = [aws_sqs_queue.terraform_queue_deadletter.arn]
  })

  tags = {
    Environment = local.environment
  }
}

resource "aws_lambda_event_source_mapping" "argyle_lambda" {
  event_source_arn = aws_sqs_queue.name.arn
  function_name    = data.terraform_remote_state.lambda.outputs.aws_lambda_function.lambda.qualified_arn
}