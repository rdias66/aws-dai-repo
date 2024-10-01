
variable "most_recent_ami" {
  description = "Set to true to get the most recent AMI that matches the specified filters."
  type        = bool
}

variable "ami_name_pattern" {
  description = "The pattern used to match the AMI name (e.g., for Ubuntu 22.04). Modify this to change the operating system or version."
  type        = string
}

variable "virtualization_type" {
  description = "Specifies the virtualization type for the AMI (e.g., hvm or paravirtual). HVM is typically used for modern instances."
  type        = string
}

variable "ami_owners" {
  description = "A list of AWS account IDs that own the AMI. By default, it uses Canonical's ID for official Ubuntu AMIs. You can modify this to use custom or third-party AMIs."
  type        = list(string)
  default = [ "hvm" ]
}

variable "ec2_ami_id" {
  description = "The Amazon Machine Image (AMI) ID used to launch the EC2 instance. An AMI is a pre-configured template that contains the operating system and other software necessary to run the instance. (e.g., Ubuntu Server 22.04 LTS' for Linux-based environments)"
  type        = string
}

variable "ec2_instance_type" {
  description = "Hardware config for EC2 instance. This specifies the amount of CPU , RAM and network performance. Common types include 't2.micro' (free tier, small workloads) and 't3.medium' (general purpose, moderate workloads)."
  type        = string
}

variable "ec2_vpc_id" {
  description = "VPC(Virtual Private Cloud) ID where the EC2 instance will be deployed, this is a isolated networkd of sorts where all of our resources will be conected to, making them able to communicate with each other(more on this in the security groups part)"
  type        = string
}

variable "ec2_key_name" {
  description = "The key name for SSH Key Pair authentication, this will be used mostly for ssh conections into your EC2 instance, this will generate a .pem file later on that must be saved in a secure spot"
  type        = string
}

variable "availability_zone" {
  description = "The availability zone in which to launch the EC2 instance (e.g., us-east-1a , sa-east-1)"
  type        = string
}

variable "ec2_associate_public_ip_address" {
  description = "Boolean flag to associate a public IP address with the EC2 instance, will be used on the domain configuration later on"
  type        = bool
}

variable "ec2_security_groups_ids" {
  description = "List of security group IDs to attach to the EC2 instance, this will configure what types of connections and permissions will be available for our instance."
  type        = list(string)
}

variable "ec2_root_volume_size" {
  description = "Size of the EC2 root volume in GB"
  type        = number
}

variable "ec2_root_volume_type" {
  description = "The type of the root volume (e.g., gp2, io1)"
  type        = string
}

variable "ec2_tag_platform" {
  description = "Tag to identify the platform of the EC2 instance (e.g., Linux/Ubuntu)"
  type        = string
}
