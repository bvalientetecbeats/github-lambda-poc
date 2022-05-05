resource "aws_api_gateway_resource" "apigtw_restapi" {
  parent_id   = aws_api_gateway_rest_api.apigtw_restapi.root_resource_id
  path_part   = "message"
  rest_api_id = aws_api_gateway_rest_api.apigtw_restapi.id
}

resource "aws_api_gateway_method" "apigtw_restapi" {
  authorization = "NONE"
  http_method   = "POST"
  resource_id   = aws_api_gateway_resource.apigtw_restapi.id
  rest_api_id   = aws_api_gateway_rest_api.apigtw_restapi.id
}

resource "aws_api_gateway_integration" "apigtw_restapi" {
  http_method             = aws_api_gateway_method.apigtw_restapi.http_method
  resource_id             = aws_api_gateway_resource.apigtw_restapi.id
  rest_api_id             = aws_api_gateway_rest_api.apigtw_restapi.id
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_arn_action
}