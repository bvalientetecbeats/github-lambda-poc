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
  name               = "'iam_for_lambda'+${var.lambda_function_name}"
  assume_role_policy = "${data.aws_iam_policy_document.policy.json}"
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/.build/"
  output_path = "${path.module}/.build/lambda_artifact.zip"
}

resource "aws_lambda_function" "lambda" {
  function_name = var.lambda_function_name
  filename         = join("", data.archive_file.lambda_zip.*.output_path)
  source_code_hash = join("", data.archive_file.lambda_zip.*.output_base64sha256)
  role    = aws_iam_role.iam_for_lambda.arn
  handler = var.lambda_handler
  runtime = var.lambda_runtime
}