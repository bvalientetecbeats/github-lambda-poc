resource "aws_api_gateway_rest_api" "apigtw_restapi" {
  name        = var.api_gtw_restapi_name
  description = "Proxy to handle the requests to Argyle Authorizer Lambda"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "apigtw_deploy" {
  rest_api_id = aws_api_gateway_rest_api.apigtw_restapi.id
  triggers = {
    redeployment = sha1(jsonencode([aws_api_gateway_resource.apigtw_restapi.id,
      aws_api_gateway_method.apigtw_restapi.id,
    aws_api_gateway_integration.apigtw_restapi.id, ]))
  }
  lifecycle {
    create_before_destroy = true
  }
}