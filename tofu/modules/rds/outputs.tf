output "address" {
  description = "O endereço (nome DNS) da instância de banco de dados, usado para fins de conexão."
  value = aws_db_instance.db.address
}

output "endpoint" {
  description = "O endpoint da instância de banco de dados, tipicamente usado na string de conexão para aplicativos."
  value = aws_db_instance.db.endpoint
}

# Opcional
output "db_instance_arn" {
  description = "O ARN da instância RDS para integrações e gerenciamento de recursos."
  value = aws_db_instance.db.arn
}

# Opcional
output "db_instance_identifier" {
  description = "O identificador único para a instância RDS, útil para identificar o recurso."
  value = aws_db_instance.db.id
}
