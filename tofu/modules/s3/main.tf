# Bloco de recurso para o bucket S3
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.environment}-${var.s3_bucket_name}"  # O nome do bucket é gerado combinando o ambiente e o nome do bucket.

  tags = {
    Name        = var.s3_bucket_name      # O nome base do bucket S3.
    Environment = var.environment         # O ambiente (ex: produção, desenvolvimento).
  }
}

# Política IAM para permitir o upload de arquivos no bucket S3.
resource "aws_iam_policy" "file_upload_policy" {
  name        = "${var.environment}-${var.s3_bucket_name}-file-upload-policy"  # O nome da política é gerado dinamicamente usando o ambiente e o nome do bucket.
  path        = "/"                                                            # Caminho da política IAM.
  description = "Política para permitir upload de arquivos no bucket S3"                

  # Definição JSON da política, permitindo a ação PutObject do S3 (upload) para o bucket.
  policy = jsonencode({
    Version   = "2012-10-17",  # Versão da política
    Statement = [
      {
        Action = [
          "s3:PutObject"  # Ação que permite o upload de objetos (arquivos) no bucket.
        ]
        Effect   = "Allow"  # Efeito da política (Permitir/Negar).
        Resource = "arn:aws:s3:::${aws_s3_bucket.s3_bucket.bucket}/*"  # ARN do recurso especifica todos os objetos dentro do bucket.
      },
    ]
  })
}

# Política IAM para permitir leitura de arquivos no bucket S3.
resource "aws_iam_policy" "file_read_policy" {
  name        = "${var.environment}-${var.s3_bucket_name}-file-read-policy"  # O nome da política é gerado dinamicamente usando o ambiente e o nome do bucket.
  path        = "/"                                                          # Caminho da política IAM.
  description = "Política para permitir leitura de arquivos no bucket S3"           

  # Definição JSON da política, permitindo a ação GetObject do S3 (leitura) para o bucket.
  policy = jsonencode({
    Version   = "2012-10-17",  # Versão da política
    Statement = [
      {
        Action = [
          "s3:GetObject"  # Ação que permite leitura de objetos (arquivos) no bucket.
        ]
        Effect   = "Allow"  # Efeito da política (Permitir/Negar).
        Resource = "arn:aws:s3:::${aws_s3_bucket.s3_bucket.bucket}/*"  # ARN do recurso especifica todos os objetos dentro do bucket.
      },
    ]
  })
}
