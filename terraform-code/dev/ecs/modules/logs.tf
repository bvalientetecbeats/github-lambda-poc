# logs.tf
# Set up CloudWatch group and log stream and retain logs for 3 days
resource "aws_cloudwatch_log_group" "react_log_group" {
  name              = "/ecs/react-poc"
  retention_in_days = 3

  tags = {
    Environment = var.tag_owner
  }
}

resource "aws_cloudwatch_log_stream" "react_log_stream" {
  name           = "react-log-stream"
  log_group_name = aws_cloudwatch_log_group.react_log_group.name
}