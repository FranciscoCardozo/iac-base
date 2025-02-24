variable "cloudfront_name" {
  description = "Nombre de la distribución de CloudFront"
  type        = string
}

variable "s3_bucket_domain" {
  description = "El dominio del bucket de S3 (ej: my-bucket.s3.amazonaws.com)"
  type        = string
}

variable "s3_origin_id" {
  description = "ID de origen para CloudFront"
  type        = string
}

variable "environment" {
  description = "Ambiente de la infraestructura (dev, staging, prod)"
  type        = string
}
