variable "api_name" {
  description = "Nombre del API Gateway"
  type        = string
}

variable "oas_file" {
  description = "Ruta del archivo OpenAPI (OAS)"
  type        = string
}

variable "stage_name" {
  description = "Nombre del Stage del API"
  type        = string
}

variable "lambda_arn_assessments" {
  description = "ARN de la Lambda"
  type        = string
}

variable "lambda_name_assessments" {
  description = "Nombre de la Lambda"
  type        = string
}

variable "lambda_arn_sandbox" {
  description = "ARN de la Lambda sandbox"
  type        = string
}

variable "lambda_name_sandbox" {
  description = "Nombre de la Lambda sandbox"
  type        = string
}

