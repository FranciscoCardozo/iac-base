variable "vpc_id" {
  description = "ID de la VPC donde se crea la instancia"
  type        = string
}

variable "subnet_id" {
  description = "ID de la subred pública para la instancia"
  type        = string
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
}

variable "instance_name" {
  description = "Nombre de la instancia EC2"
  type        = string
}
