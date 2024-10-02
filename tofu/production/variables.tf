# Shared Variables
variable "region" {
   type = string
}
variable "environment" {
  type = string
}
variable "vpc_id" {
  type = string
}


# EC2 Variables
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


# RDS Variables
variable "rds_monitoring_role_policy_arn" {
  type    = string
}
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


# ECR Variables 
# In the footprint case of this tutorial we would need two repos for our backend and frontend images respectively
# If in your case you only need one, or need more, adjust accordingly. In this case both will be staged as production, so we will use one var.
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
  type    = boolean
}
variable "ecr_image_tag_mutability" {
  type    = string
}


# S3 Related variables
variable "s3_bucket_name" {
  type    = string
}

# All security group related variables will be handled directly in the main.tf file for production
# through the security-group modules.