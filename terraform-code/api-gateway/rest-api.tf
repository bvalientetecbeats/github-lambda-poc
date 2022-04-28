resource "aws_api_gateway_rest_api" "api_gtw_restapi_poc" {
  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = "API-Gateway-POC"
      version = "1.0"
    }
    paths = {
      "/path1" = {
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

  name = var.api_gtw_restapi_name_dev

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

resource "aws_api_gateway_stage" "default" {
  deployment_id = aws_api_gateway_deployment.api_gtw_deploy.id
  rest_api_id   = aws_api_gateway_rest_api.api_gtw_deploy.id
  stage_name    = "default"

  settings {
    metrics_enabled = true
  }
}