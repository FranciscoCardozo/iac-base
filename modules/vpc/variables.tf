variable "cidr_block" {
  description = "Rango de IPs de la VPC"
  type        = string
}

variable "vpc_name" {
  description = "Nombre de la VPC"
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR para la subred privada"
  type        = string
}

variable "availability_zone" {
  description = "Zona de disponibilidad"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR para la subred pública"
  type        = string
}

variable "public_availability_zone" {
  description = "Zona de disponibilidad de la subred pública"
  type        = string
}
