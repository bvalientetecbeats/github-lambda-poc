resource "aws_api_gateway_rest_api" "api_gtw_restapi_poc" {
  name = var.api_gtw_restapi_name
  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = "API-Gateway-Argyle"
      version = "1.0"
    }
    paths = {
      "/path0" = {
        get = {
          x-amazon-apigateway-integration = {
            httpMethod           = "GET"
            payloadFormatVersion = "1.0"
            type                 = "HTTP_PROXY"
            uri                  = "https://ip-ranges.amazonaws.com/ip-ranges.json"
          }
        }
      }
    }
  })
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "api_gtw_deploy" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw_restapi_poc.id
  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.api_gtw_restapi_poc.body))
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "stage_default" {
  deployment_id = aws_api_gateway_deployment.api_gtw_deploy.id
  rest_api_id   = aws_api_gateway_rest_api.api_gtw_restapi_poc.id
  stage_name    = var.stage_name
}