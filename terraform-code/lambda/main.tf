# Specify the provider and access details
provider "aws" {
  region = local.aws_region
}

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
  name               = "iam_for_lambda_${local.lambda_function_name}"
  assume_role_policy = data.aws_iam_policy_document.policy.json
}

resource "aws_lambda_function" "lambda" {
  filename         = "lambda_artifact.zip"
  function_name    = local.lambda_function_name
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = local.lambda_handler
  source_code_hash = filebase64sha256("lambda_artifact.zip")
  runtime          = local.lambda_runtime

  environment {
    variables = {
      test = "poctest"
    }
  }
}