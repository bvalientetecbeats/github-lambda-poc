output "sqs_url_data_source" {
  value = aws_sqs_queue.argyle_dlq.url
}

output "sqs_url_resource_attribute" {
  value = aws_sqs_queue.argyle_dlq.id
}