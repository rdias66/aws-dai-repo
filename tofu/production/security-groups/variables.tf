// Variável para o ID da VPC onde os Security Groups serão criados
variable "vpc_id" {
  description = "O ID da VPC a ser associado aos Security Groups"
  type        = string
}

// Variável para o nome do Security Group do EC2
variable "ec2_sg_name" {
  description = "O nome do Security Group para o EC2"
  type        = string
  default     = "ec2-sg"
}

// Variável para o nome do Security Group EC2-RDS
variable "ec2_rds_sg_name" {
  description = "O nome do Security Group para EC2-RDS"
  type        = string
  default     = "ec2-rds-sg"
}

// Variável para o nome do Security Group do RDS
variable "rds_ec2_sg_name" {
  description = "O nome do Security Group para o RDS"
  type        = string
  default     = "rds-ec2-sg"
}
