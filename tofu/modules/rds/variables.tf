
# More info on official AWS documentation, AWS Management Console, and Terraform provider documentation(OpenTofu in our case)
variable "rds_monitoring_role_policy_arn" {
  description = "ARN of the managed policy for RDS Enhanced Monitoring"
  type        = string
  default     = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

variable "environment" {
  description = "The environment of the deployment(e.g., dev, staging, production)"
  type        = string
}

variable "availability_zone" {
  description = "Defines the AWS availability zone for the RDS instance, this will be the same var for the entire IaC"
  type = string
}

variable "db_allocated_storage" {
  description = "The amount of storage (in gigabytes) to be initially allocated for the database, important to check limits for free tier if thats your goal"
  type        = number
}

variable "db_max_allocated_storage" {
  description = "The maximum amount of storage (in gigabytes) that can be allocated for the database"
  type        = number
}

variable "db_engine" {
  description = "Species the database engine (e.g., mysql, postgres)"
  type        = string
}

variable "db_engine_version" {
  description = "The version of the database engine to use"
  type        = string
}

variable "db_parameter_group_name" {
  description = "The name of the DB parameter group to associate with the instance"
  type        = string
}

variable "db_instance_class" {
  description = "The instance type of the RDS instance (e.g., db.t2.micro)"
  type        = string
}

variable "db_user" {
  description = "The username for connection to be declared on production variables"
  type        = string
  sensitive   = true  # Mark as sensitive to prevent it from being shown in logs
}

# Variable for the password used to connect to the database
variable "db_password" {
  description = "The password for connection to be declared on production variables"
  type        = string
  sensitive   = true  # Mark as sensitive to prevent it from being shown in logs
}

variable "db_port" {
  description = "The port used for connectionto the database (default is usually 3306)"
  type        = number
  sensitive   = true  # Mark as sensitive to prevent it from being shown in logs
}

variable "db_database" {
  description = "The name of the initial database to create"
  type        = string
}

variable "db_backup_retention_period" {
  description = "The number of days to retain backups"
  type        = number
}

variable "db_monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected, the shorter the costier, this will provide more granular data for affects pricing."
  type        = number
}

variable "db_multi_az" {
  description = "Specifies if the RDS instance is multi-AZ, this will deploy the db instance in multiple availability zones, so it can increse pricing, for free tier, false is better"
  type        = bool
}

variable "db_publicly_accessible" {
  description = "Bool to control if instance is publicly accessible"
  type        = bool
}

variable "db_storage_encrypted" {
  description = "Enables encryptioin at rest, this does not affect overall how you will consume and use this instance, but it can lead to price increases. If eventual cost is not a problem always set to true"
  type        = bool
  default     = false  
}

variable "db_storage_type" {
  description = "One of 'standard', 'gp2', or 'io1', this affects the performance and price, standard is better for free tier and the following gp2 and io1 scale the performance and price relatively.(both are SSD based)"
  type        = string
}

variable "db_tag_platform" {
  description = "Tag to identify the platform"
  type        = string
}

variable "db_security_groups_names" {
  description = "A list of security group names to assign to the instance"
  type        = list(string)
}
