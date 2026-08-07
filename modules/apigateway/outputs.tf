output "assessments_url" {
  value = aws_api_gateway_stage.stage_assessments.invoke_url
}

output "assessments_execution_arn" {
  value = aws_api_gateway_rest_api.api_assessments.execution_arn
}