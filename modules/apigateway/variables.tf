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

variable "lambda_arn_cinema" {
  description = "Nombre del Stage del API"
  type        = string
}

variable "lambda_name_cinema" {
  description = "Nombre de la Lambda"
  type        = string
}

variable "lambda_role_name_cinema" {
  description = "Nombre de la Lambda"
  type        = string
}
