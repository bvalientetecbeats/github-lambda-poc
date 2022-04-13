# Specify the provider and access details
provider "aws" {
  region = var.aws_region
}

data "aws_iam_policy_document" "policy" {
  statement {
    sid    = "lambda-policy-poc"
    effect = "Allow"
    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = "${data.aws_iam_policy_document.policy.json}"
}

resource "aws_lambda_function" "lambda" {
  function_name = var.lambda_function_name
  filename         = "./.build/Lambda_Artifact.zip"
  source_code_hash = filebase64sha256("./.build/Lambda_Artifact.zip")
  role    = aws_iam_role.iam_for_lambda.arn
  handler = var.lambda_handler
  runtime = var.lambda_runtime
}