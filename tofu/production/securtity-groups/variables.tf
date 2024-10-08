// Variable for the VPC ID where the security groups will be created
variable "vpc_id" {
  description = "The ID of the VPC to associate the security groups with"
  type        = string
}

// Variable for the EC2 security group name
variable "ec2_sg_name" {
  description = "The name for the EC2 security group"
  type        = string
  default     = "ec2-sg"
}

// Variable for the EC2-RDS security group name
variable "ec2_rds_sg_name" {
  description = "The name for the EC2-RDS security group"
  type        = string
  default     = "ec2-rds-sg"
}

// Variable for the RDS security group name
variable "rds_ec2_sg_name" {
  description = "The name for the RDS security group"
  type        = string
  default     = "rds-ec2-sg"
}
