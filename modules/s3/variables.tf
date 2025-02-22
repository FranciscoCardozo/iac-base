variable "bucket_name" {
  description = "Nombre del bucket de S3"
  type        = string
}

variable "bucket_acl" {
  description = "Política de acceso al bucket"
  type        = string
  default     = "private"
}

variable "environment" {
  description = "Ambiente de la infraestructura (dev, staging, prod)"
  type        = string
}

variable "versioning_enabled" {
  description = "Habilitar versionado en el bucket"
  type        = bool
  default     = true
}
