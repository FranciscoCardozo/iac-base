output "assessments_arn" {
  value = aws_lambda_function.assessments_function.arn
}

output "assessments_role_name" {
  value       = aws_iam_role.lambda_role_assessments.name
  description = "Nombre del rol IAM asociado a la Lambda"
}