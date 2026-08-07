resource "aws_api_gateway_rest_api" "api_cinema" {
  name        = "API_Cinema"
  description = "API Gateway basado en OpenAPI"

  body = templatefile(var.oas_file, {
    lambda_arn = var.lambda_arn_assessments
  })
}

resource "aws_api_gateway_deployment" "deployment_cinema" {
  rest_api_id = aws_api_gateway_rest_api.api_cinema.id
}

resource "aws_api_gateway_stage" "stage_cinema" {
  rest_api_id   = aws_api_gateway_rest_api.api_cinema.id
  stage_name    = var.stage_name
  deployment_id = aws_api_gateway_deployment.deployment_cinema.id

  lifecycle {
    ignore_changes = [deployment_id]
  }
}

resource "aws_lambda_permission" "apigateway_cinema" {
  statement_id  = "AllowAPIGatewayInvoke-${var.lambda_name_assessments}"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_name_assessments
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api_cinema.execution_arn}/*/*"
}

output "api_gateway_url_cinema" {
  value = aws_api_gateway_stage.stage_cinema.invoke_url
}
