resource "aws_api_gateway_rest_api" "api" {
  name        = var.api_name
  description = "API Gateway para la Lambda"

  body = templatefile("./api.json",{
    lambda_arn = var.lambda_arn
  }) # Carga el archivo OpenAPI (OAS)
}

resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = aws_api_gateway_rest_api.api.id
}

resource "aws_api_gateway_stage" "stage" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  stage_name    = var.stage_name
  deployment_id = aws_api_gateway_deployment.deployment.id

  lifecycle {
    ignore_changes = [deployment_id]
  }
}

output "api_gateway_url" {
  value = aws_api_gateway_stage.stage.invoke_url
}
