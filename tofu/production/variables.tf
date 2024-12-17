# Variáveis compartilhadas
variable "region" {
   type = string
}
variable "environment" {
  type = string
}

# Variáveis VPC 
variable "vpc_id"{
  type = string
}

# Variáveis EC2
variable "most_recent_ami" {
  type        = bool
}
variable "ami_name_pattern" {
  type        = string
}
variable "virtualization_type" {
  type        = string
}
variable "ami_owners" {
  type        = list(string)
}
variable "ec2_ami_id" {
  type    = string
}
variable "ec2_instance_type" {
  type    = string
}
variable "ec2_key_name" {
  type        = string
}
variable "ec2_associate_public_ip_address" {
  type    = bool
}
variable "ec2_tag_platform" {
  type    = string
}
variable "ec2_root_volume_type" {
  type    = string
}
variable "ec2_root_volume_size" {
  type    = number
}


# Variáveis RDS

variable "db_allocated_storage" {
  type    = number
}
variable "db_max_allocated_storage" {
  type    = number
}
variable "availability_zone" {
  type = string
}
variable "db_engine" {
  type    = string
}
variable "db_engine_version" {
  type    = string
}
variable "db_parameter_group_name" {
  type    = string
}
variable "db_instance_class" {
  type    = string
}
variable "db_user" {
  description = "The username for database connection"
  type        = string
  sensitive   = true
}
variable "db_password" {
  description = "The password for database connection"
  type        = string
  sensitive   = true
}
variable "db_database" {
  description = "The database for database connection"
  type        = string
  sensitive   = true
}
variable "db_port" {
  description = "The database for database connection"
  type        = number
  sensitive   = true
}
variable "db_backup_retention_period" {
  type    = number
}
variable "db_monitoring_interval" {
  type    = number
}
variable "db_multi_az" {
  type    = bool
}
variable "db_publicly_accessible" {
  type    = bool
}
variable "db_storage_encrypted" {
  type        = bool 
}
variable "db_storage_type" {
  type    = string
}
variable "db_tag_platform" {
  type    = string
}


# Variáveis ECR
# Na base deste repositório precisamos de dois repositorios 
# Caso voce precise de um ou mais, ajuste de acordo seguindo o padrão.
variable "backend_ecr_repo_name" {
  type    = string
}
variable "frontend_ecr_repo_name" {
  type    = string
}
variable "ecr_platform" {
  type    = string
}
variable "ecr_scan_on_push" {
  type    = bool
}
variable "ecr_image_tag_mutability" {
  type    = string
}


# Variáveis S3
variable "s3_bucket_name" {
  type    = string
}

# Todas as variáveis referentes aos grupos de segurança serao mockadas na main.tf atraves do modulo do security-group
