resource "aws_sqs_queue" "sqs_queue" {
  name                      = var.sqs_name
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.sqs_dlq.arn
    maxReceiveCount     = 2
  })
  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = [aws_sqs_queue.sqs_dlq.arn]
  })

  tags = {
    Environment = var.environment
  }
}

resource "aws_sqs_queue" "sqs_dlq" {
  name = var.sqs_dlq_name
}

resource "aws_lambda_event_source_mapping" "sqs_lambda" {
  event_source_arn = aws_sqs_queue.sqs_queue.arn
  function_name    = var.lambda_arn
}