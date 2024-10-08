// Main Security Group Configuration for AWS Infrastructure

// EC2 Security Group for inbound traffic to the instance
resource "aws_security_group" "ec2_sg" {
  name        = var.ec2_sg_name
  description = "Allow inbound traffic to EC2 instances"
  vpc_id      = var.vpc_id

  // HTTP (port 80) inbound rule
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  // Allow access from any IP address
  }

  // HTTPS (port 443) inbound rule
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  // Allow access from any IP address
  }

  // SSH (port 22) inbound rule - Ideally restrict this to specific IPs in production
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  // Open to all, but restrict for security in real scenarios
  }

  // Outbound traffic rule to allow all outgoing traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  // "-1" allows all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
}

// Security Group for EC2-RDS communication
resource "aws_security_group" "ec2_rds_sg" {
  name        = var.ec2_rds_sg_name
  description = "Allow EC2 to communicate with RDS over PostgreSQL (port 5432)"
  vpc_id      = var.vpc_id

  // Outbound rule allowing EC2 to reach RDS on port 5432 (PostgreSQL)
  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  // Allow communication to all addresses (to be restricted in real setups)
  }
}

// Security Group for RDS inbound traffic (from EC2)
resource "aws_security_group" "rds_ec2_sg" {
  name        = var.rds_ec2_sg_name
  description = "Allow inbound PostgreSQL traffic for RDS from EC2 instances"
  vpc_id      = var.vpc_id

  // Outbound traffic rule to allow all outgoing traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

// Rule to allow EC2 to communicate with RDS
resource "aws_security_group_rule" "ec2_to_rds" {
  type                     = "egress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ec2_rds_sg.id
  source_security_group_id = aws_security_group.ec2_sg.id
  description              = "Allow EC2 instances to communicate with RDS over port 5432"
}

// Rule to allow RDS to accept traffic from EC2
resource "aws_security_group_rule" "rds_from_ec2" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds_ec2_sg.id
  source_security_group_id = aws_security_group.ec2_rds_sg.id
  description              = "Allow RDS to accept traffic from EC2 over port 5432"
}
