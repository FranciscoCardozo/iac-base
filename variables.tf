#CONECTION
variable "access_key" {
  description = "nombre key acceso"
  type        = string
  sensitive   = true
}

variable "secret_key" {
  description = "secreto de acceso"
  type        = string
  sensitive   = true
}

variable "accound_id" {
  description = "id de cuenta"
  type        = string
  sensitive   = true
}