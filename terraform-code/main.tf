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
  function_name = "${TF_VAR_LAMBDA_FUNCTION_NAME}"
  filename         = "Lambda_${CODEBUILD_BUILD_NUMBER}.zip"
  source_code_hash = filebase64sha256("Lambda_${CODEBUILD_BUILD_NUMBER}.zip")
  role    = aws_iam_role.iam_for_lambda.arn
  handler = "${TF_VAR_LAMBDA_HANDLER}"
  runtime = "${TF_VAR_LAMBDA_RUNTIME}"
}