variable "environment" {
  description = "O ambiente (ex: produção, desenvolvimento) onde o bucket S3 será criado."
  type        = string
}

variable "s3_bucket_name" {
  description = "O nome base do bucket S3. Este valor será combinado com a variável de ambiente para gerar o nome completo do bucket."
  type        = string
}
