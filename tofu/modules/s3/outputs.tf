output "s3_bucket_name" {
  value       = aws_s3_bucket.s3_bucket.bucket  
  description = "Retorna o nome do bucket criado"  
  
}
