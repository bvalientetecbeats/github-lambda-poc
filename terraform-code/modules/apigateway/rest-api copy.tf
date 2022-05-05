resource "aws_api_gateway_rest_api" "apigtw_restapi" {
  name = var.api_gtw_restapi_name
  description = "Proxy to handle the requests to Argyle Authorizer Lambda"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "apigtw_restapi" {
  parent_id   = aws_api_gateway_rest_api.apigtw_restapi.root_resource_id
  path_part   = "message"
  rest_api_id = aws_api_gateway_rest_api.apigtw_restapi.id
}

resource "aws_api_gateway_method" "apigtw_restapi" {
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = aws_api_gateway_resource.apigtw_restapi.id
  rest_api_id   = aws_api_gateway_rest_api.apigtw_restapi.id
}

resource "aws_api_gateway_integration" "apigtw_restapi" {
  http_method = aws_api_gateway_method.apigtw_restapi.http_method
  resource_id = aws_api_gateway_resource.apigtw_restapi.id
  rest_api_id = aws_api_gateway_rest_api.apigtw_restapi.id
  integration_http_method = "POST"
  type        = "AWS_PROXY"
  uri = var.lambda_arn
}

resource "aws_api_gateway_deployment" "apigtw_deploy" {
  rest_api_id = aws_api_gateway_rest_api.apigtw_restapi.id
  triggers = {
    redeployment = sha1(jsonencode([aws_api_gateway_resource.apigtw_restapi.id,
      aws_api_gateway_method.apigtw_restapi.id,
      aws_api_gateway_integration.apigtw_restapi.id,]))
  }
  lifecycle {
    create_before_destroy = true
  }
}

#resource "aws_api_gateway_stage" "stage_default" {
#  deployment_id = aws_api_gateway_deployment.apigtw_deploy.id
#  rest_api_id   = aws_api_gateway_rest_api.apigtw_restapi.id
#  stage_name    = var.stage_name
#}