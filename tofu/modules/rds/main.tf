# IAM Role for RDS Enhanced Monitoring , this does not affect pricing
# IAM Role for RDS Enhanced Monitoring
resource "aws_iam_role" "RDSMonitoringRole" {
  name               = "RDSMonitoringRole"
  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "monitoring.rds.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name     = "RDS Monitoring Role"
    Platform = "Database"
    Type     = "Service"
  }
}

# Attach the AmazonRDSEnhancedMonitoringRole policy
resource "aws_iam_role_policy_attachment" "RDSMonitoringRolePolicy" {
  role       = aws_iam_role.RDSMonitoringRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}


# Resource block for creating an RDS database instance
resource "aws_db_instance" "db" {
  allocated_storage                   = var.db_allocated_storage
  max_allocated_storage               = var.db_max_allocated_storage
  engine                              = var.db_engine
  engine_version                      = var.db_engine_version
  instance_class                      = var.db_instance_class
  db_name                             = var.db_database
  username                            = var.db_user
  password                            = var.db_password
  port                                = var.db_port
  parameter_group_name                = var.db_parameter_group_name
  skip_final_snapshot                 = true
  backup_retention_period             = var.db_backup_retention_period
  copy_tags_to_snapshot               = true
  monitoring_interval                 = var.db_monitoring_interval
  monitoring_role_arn                 = aws_iam_role.RDSMonitoringRole.arn
  multi_az                            = var.db_multi_az
  publicly_accessible                 = var.db_publicly_accessible
  storage_encrypted                   = var.db_storage_encrypted 
  storage_type                        = var.db_storage_type
  iam_database_authentication_enabled = true
  availability_zone                   = var.availability_zone
  tags = {
    Name     = "DB"                  # Tag for identifying the database instance
    Platform = var.db_tag_platform    # Tag for platform identification
    Type     = "Service"              # Type tag for resource classification
  }
}
