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
  function_name = var.function_name
  filename         = "Lambda_${var.build_number}.zip"
  source_code_hash = filebase64sha256("Lambda_${var.build_number}.zip")
  role    = aws_iam_role.iam_for_lambda.arn
  handler = local.handler
  runtime = local.runtime
}