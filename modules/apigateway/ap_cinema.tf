resource "aws_api_gateway_rest_api" "api_cinema" {
  name        = "API_Cinema"
  description = "API Gateway conectado con Lambda"
}

# Recurso de la API Gateway
resource "aws_api_gateway_resource" "proxy_cinema" {
  rest_api_id = aws_api_gateway_rest_api.api_cinema.id
  parent_id   = aws_api_gateway_rest_api.api_cinema.root_resource_id
  path_part   = "{proxy+}"
}

# Método HTTP para invocar Lambda
resource "aws_api_gateway_method" "proxy_cinema" {
  rest_api_id   = aws_api_gateway_rest_api.api_cinema.id
  resource_id   = aws_api_gateway_resource.proxy_cinema.id
  http_method   = "ANY"
  authorization = "NONE"
}

# Integración con la Lambda
resource "aws_api_gateway_integration" "proxy_cinema" {
  rest_api_id             = aws_api_gateway_rest_api.api_cinema.id
  resource_id             = aws_api_gateway_resource.proxy_cinema.id
  http_method             = aws_api_gateway_method.proxy_cinema.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/${var.lambda_arn_cinema}/invocations"
}

resource "aws_api_gateway_method" "root_cinema" {
  rest_api_id   = aws_api_gateway_rest_api.api_cinema.id
  resource_id   = aws_api_gateway_rest_api.api_cinema.root_resource_id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "root_cinema" {
  rest_api_id             = aws_api_gateway_rest_api.api_cinema.id
  resource_id             = aws_api_gateway_rest_api.api_cinema.root_resource_id
  http_method             = aws_api_gateway_method.root_cinema.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/${var.lambda_arn_cinema}/invocations"
}

# Desplegar la API
resource "aws_api_gateway_deployment" "deployment_cinema" {
  rest_api_id = aws_api_gateway_rest_api.api_cinema.id
  depends_on  = [
    aws_api_gateway_integration.proxy_cinema,
    aws_api_gateway_integration.root_cinema
  ]
}
# Crear un stage para la API
resource "aws_api_gateway_stage" "stage_cinema" {
  deployment_id = aws_api_gateway_deployment.deployment_cinema.id
  rest_api_id   = aws_api_gateway_rest_api.api_cinema.id
  stage_name    = var.stage_name
}

# **🔹 Permiso para que API Gateway invoque Lambda**
resource "aws_lambda_permission" "apigateway_cinema" {
  statement_id  = "AllowAPIGatewayInvoke-${var.lambda_name_cinema}"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_name_cinema
  principal     = "apigateway.amazonaws.com"
  source_arn = "${aws_api_gateway_rest_api.api_cinema.execution_arn}/*"
}

# **🔹 Output para ver la URL de la API**
output "api_gateway_url_cinema" {
  value = aws_api_gateway_stage.stage_cinema.invoke_url
}
