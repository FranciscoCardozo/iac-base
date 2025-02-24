output "cinema_url" {
  value = aws_api_gateway_stage.stage_cinema.invoke_url
}

output "cinema_execution_arn" {
  value = aws_api_gateway_rest_api.api_cinema.execution_arn
}