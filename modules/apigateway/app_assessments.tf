resource "aws_api_gateway_rest_api" "api_assessments" {
  name        = "API_Assessments"
  description = "API Gateway basado en OpenAPI"

  body = templatefile(var.oas_file, {
    lambda_arn = var.lambda_arn_assessments
  })
}

resource "aws_api_gateway_deployment" "deployment_assessments" {
  rest_api_id = aws_api_gateway_rest_api.api_assessments.id

  triggers = {
    redeployment = sha1(templatefile(var.oas_file, {
      lambda_arn = var.lambda_arn_assessments
    }))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "stage_assessments" {
  rest_api_id   = aws_api_gateway_rest_api.api_assessments.id
  stage_name    = var.stage_name
  deployment_id = aws_api_gateway_deployment.deployment_assessments.id

}

resource "aws_lambda_permission" "apigateway_assessments" {
  statement_id  = "AllowAPIGatewayInvoke-${var.lambda_name_assessments}"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_name_assessments
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api_assessments.execution_arn}/*/*"
}

output "api_gateway_url_assessments" {
  value = aws_api_gateway_stage.stage_assessments.invoke_url
}
