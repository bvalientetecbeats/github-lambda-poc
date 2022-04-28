resource "aws_api_gateway_stage" "default" {
  deployment_id = aws_api_gateway_deployment.api_gtw_deploy.id
  rest_api_id   = aws_api_gateway_rest_api.api_gtw_deploy.id
  stage_name    = "default"
  
  settings {
    metrics_enabled = true
  }
}