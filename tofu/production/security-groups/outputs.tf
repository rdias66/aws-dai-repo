// Output dos IDs dos grupos de segurança para referência e uso em outros módulos
output "ec2_sg_id" {
  description = "O ID do grupo de segurança para o EC2"
  value       = aws_security_group.ec2_sg.id
}

output "ec2_rds_sg_id" {
  description = "O ID do grupo de segurança para a comunicação entre EC2 e RDS"
  value       = aws_security_group.ec2_rds_sg.id
}

output "rds_ec2_sg_id" {
  description = "O ID do grupo de segurança para a comunicação entre RDS e EC2"
  value       = aws_security_group.rds_ec2_sg.id
}
