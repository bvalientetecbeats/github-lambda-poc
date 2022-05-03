data "aws_iam_policy_document" "policy" {
  statement {
    effect = "Allow"
    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda_${var.lambda_function_name}"
  assume_role_policy = data.aws_iam_policy_document.policy.json
}

resource "aws_lambda_function" "lambda" {
  filename         = "lambda_artifact.zip"
  function_name    = var.lambda_function_name
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = var.lambda_handler
  source_code_hash = filebase64sha256("lambda_artifact.zip")
  runtime          = var.lambda_runtime

  environment {
    variables = {
      test = var.tag_owner
    }
  }
}