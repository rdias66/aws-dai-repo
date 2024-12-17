// Configuração principal do Security Group para a infraestrutura AWS

// Security Group do EC2 para tráfego de entrada na instância
resource "aws_security_group" "ec2_sg" {
  name        = var.ec2_sg_name
  description = "Permitir tráfego de entrada para instâncias EC2"
  vpc_id      = var.vpc_id

  // Regra de entrada HTTP (porta 80)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  // Permitir acesso de qualquer endereço IP
  }

  // Regra de entrada HTTPS (porta 443)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  // Permitir acesso de qualquer endereço IP
  }

  // Regra de entrada SSH (porta 22) - Idealmente restrinja isso a IPs específicos em produção
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  // Aberto para todos, mas restrinja para segurança em cenários reais
  }

  // Regra de tráfego de saída para permitir todo o tráfego de saída
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  // "-1" permite todos os protocolos
    cidr_blocks = ["0.0.0.0/0"]
  }
}

// Security Group para permitir comunicação entre EC2 e RDS na porta PostgreSQL (5432)
resource "aws_security_group" "ec2_rds_sg" {
  name        = var.ec2_rds_sg_name
  description = "Permitir que o EC2 se comunique com o RDS pela porta 5432"
  vpc_id      = var.vpc_id

  // Regra para permitir acesso à porta do RDS (5432)
  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  // Permitir acesso de qualquer IP (disponibilidade para nosso domínio público)
  }
}

// Security Group para permitir o envio de dados do RDS para o EC2
resource "aws_security_group" "rds_ec2_sg" {
  name        = var.rds_ec2_sg_name
  description = "Permitir tráfego de entrada PostgreSQL para o RDS vindo de instâncias EC2"
  vpc_id      = var.vpc_id

  // Regra para permitir saída de dados
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

// Regra para permitir que o EC2 envie tráfego para o RDS
resource "aws_security_group_rule" "ec2_to_rds" {
  type                     = "egress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ec2_rds_sg.id
  source_security_group_id = aws_security_group.ec2_sg.id
  description              = "Permitir que instâncias EC2 se comuniquem com o RDS na porta 5432"
}

// Regra para permitir que o RDS aceite tráfego vindo do EC2
resource "aws_security_group_rule" "rds_from_ec2" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds_ec2_sg.id
  source_security_group_id = aws_security_group.ec2_rds_sg.id
  description              = "Permitir que o RDS aceite tráfego vindo do EC2 na porta 5432"
}
