output "cinema_arn" {
  value = aws_lambda_function.cinema_function.arn
}

output "cinema_role_name" {
  value       = aws_iam_role.lambda_role_cinema.name
  description = "Nombre del rol IAM asociado a la Lambda"
}