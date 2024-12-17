variable "repo_name" {
  description = "O nome do repositório ECR. Isso será usado para identificar o repositório na AWS."
  type        = string
}

variable "platform" {
  description = "A plataforma/ambiente associado ao repositório ECR (exemplo: produção, staging)."
  type        = string
}

variable "scan_on_push" {
  description = "Se deve habilitar o escaneamento de imagens ao enviar para o repositório ECR. Defina como true para habilitar."
  type        = bool
}

variable "image_tag_mutability" {
  description = "Especifica se as tags de imagem podem ser sobrescritas. Use 'MUTABLE' para permitir sobrescrita ou 'IMMUTABLE' para impedir."
  type        = string
}
