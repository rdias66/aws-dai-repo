# Terraform block to configure a remote backend using Amazon S3 to store and manage the Terraform state file securely.
terraform {
  backend "s3" {
    bucket = "your-terraform-bucket"
    key    = "platform/terraform.tfstate"
    region = "sa-east-1"
  }
}

provider "aws" {
  region = var.region
}

module "security_groups" {
  source = "./security-groups"
  vpc_id = var.vpc_id
}

module "db" {
  source                     = "../modules/rds"
  environment                = var.environment
  db_allocated_storage       = var.db_allocated_storage
  db_max_allocated_storage   = var.db_max_allocated_storage
  db_engine                  = var.db_engine
  db_engine_version          = var.db_engine_version
  db_parameter_group_name    = var.db_parameter_group_name
  db_instance_class          = var.db_instance_class
  db_user                    = var.db_user
  db_password                = var.db_password
  db_port                    = var.db_port
  db_database                = var.db_database
  db_backup_retention_period = var.db_backup_retention_period
  db_monitoring_interval     = var.db_monitoring_interval
  db_multi_az                = var.db_multi_az
  db_publicly_accessible     = var.db_publicly_accessible
  db_storage_encrypted       = var.db_storage_encrypted
  db_storage_type            = var.db_storage_type
  db_tag_platform            = var.db_tag_platform
  db_security_groups_names   = [module.security_groups.rds_ec2_sg_id]
  availability_zone          = var.availability_zone
}

module "s3_bucket" {
  source         = "../modules/s3"
  environment    = var.environment
  s3_bucket_name = var.s3_bucket_name
}

module "ec2" {
  source                          = "../modules/ec2"
  most_recent_ami                 = var.most_recent_ami
  ami_name_pattern                = var.ami_name_pattern
  virtualization_type             = var.virtualization_type
  ami_owners                      = var.ami_owners
  ec2_ami_id                      = var.ec2_ami_id
  ec2_key_name                    = var.ec2_key_name
  ec2_vpc_id                      = var.vpc_id
  ec2_root_volume_type            = var.ec2_root_volume_type
  ec2_root_volume_size            = var.ec2_root_volume_size
  ec2_instance_type               = var.ec2_instance_type
  ec2_associate_public_ip_address = var.ec2_associate_public_ip_address
  ec2_security_groups_ids         = [module.security_groups.ec2_sg_id]
  ec2_tag_platform                = var.ec2_tag_platform
  availability_zone               = var.availability_zone
}

module "ecr_backend" {
  source               = "../modules/ecr"
  repo_name            = var.backend_ecr_repo_name
  platform             = var.ecr_platform
  image_tag_mutability = var.ecr_image_tag_mutability
  scan_on_push         = var.ecr_scan_on_push
}

module "ecr_frontend" {
  source               = "../modules/ecr"
  repo_name            = var.frontend_ecr_repo_name
  platform             = var.ecr_platform
  image_tag_mutability = var.ecr_image_tag_mutability
  scan_on_push         = var.ecr_scan_on_push
}