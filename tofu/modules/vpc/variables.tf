variable "cidr_block" {
  description = "The IP range for the VPC in CIDR notation (e.g., 10.0.0.0/16)"
  type = string
}

variable "enable_dns_support" {
  description = "Enable or disable DNS resolution within the VPC (set to true for most cases)"
  type = bool
}

variable "enable_dns_hostnames" {
  description = "Enable or disable DNS hostnames for instances launched into the VPC"
  type = bool
}

variable "vpc_name"{
  description = "A name for the VPC to help with identification in AWS Console"
  type = string
}