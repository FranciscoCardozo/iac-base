variable "lambda_name" {
  description = "Nombre de la Lambda"
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

variable "dynamodb_table_arn" {
  description = "ARN de la tabla DynamoDB utilizada por la Lambda"
  type        = string
}

variable "ec2_instance_arn" {
  description = "ARN de la instancia EC2 accesible por la Lambda sandbox"
  type        = string
}

variable "sandbox_lambda_name" {
  description = "Nombre de la Lambda sandbox"
  type        = string
  default     = "lambda_sandbox"
}

