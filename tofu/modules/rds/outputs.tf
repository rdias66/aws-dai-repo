output "address" {
  description = "The address (DNS name) of the database instance, used for connection purposes."
  value = aws_db_instance.db.address
}
output "endpoint" {
  description = " The endpoint of the database instance, typically used in the connection string for applications."
  value = aws_db_instance.db.endpoint
}

# Optional
output "db_instance_arn" {
  description = "The ARN of the RDS instance for further integrations and resource management."
  value = aws_db_instance.db.arn
}

# Optional
output "db_instance_identifier" {
  description = "The unique identifier for the RDS instance, useful for identifying the resource."
  value = aws_db_instance.db.id
}
