variable "lambda_name" {
  description = "Nombre de la Lambda"
  type        = string
}

variable "lambda_zip" {
  description = "Ruta del archivo ZIP de la Lambda"
  type        = string
}

variable "subnet_ids" {
  description = "Lista de subredes privadas para la Lambda"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security Group de la Lambda"
  type        = string
}

variable "aws_region" {
  description = "Security Group de la Lambda"
  type        = string
}

variable "aws_account_id" {
  description = "Security Group de la Lambda"
  type        = string
}

variable "api_execution_arn" {
  description = "Security Group de la Lambda"
  type        = string
}
