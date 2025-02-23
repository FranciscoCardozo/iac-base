resource "aws_api_gateway_rest_api" "api_cinema" {
  name        = "API_Cinema"
  description = "API Gateway basado en OpenAPI"

  # Cargar el archivo OpenAPI (OAS)
  body = templatefile("./api.json", {
    lambda_arn = var.lambda_arn_cinema
  })
}

# Desplegar la API Gateway
resource "aws_api_gateway_deployment" "deployment_cinema" {
  rest_api_id = aws_api_gateway_rest_api.api_cinema.id
}

# Crear un stage para la API
resource "aws_api_gateway_stage" "stage_cinema" {
  rest_api_id   = aws_api_gateway_rest_api.api_cinema.id
  stage_name    = var.stage_name
  deployment_id = aws_api_gateway_deployment.deployment_cinema.id

  lifecycle {
    ignore_changes = [deployment_id]
  }
}

# **🔹 Permiso para que API Gateway invoque Lambda**
resource "aws_lambda_permission" "apigateway_cinema" {
  statement_id  = "AllowAPIGatewayInvoke-${var.lambda_name_cinema}"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_name_cinema
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api_cinema.execution_arn}/*"
}

# **🔹 Output para ver la URL de la API**
output "api_gateway_url_cinema" {
  value = aws_api_gateway_stage.stage_cinema.invoke_url
}
