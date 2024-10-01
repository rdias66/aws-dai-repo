# This block is called data source, it allows OpenTofu to fetch information about the existing AWS resource
# specified through the filters and information set in here
data "aws_ami" "ubuntu" {
  most_recent = var.most_recent_ami  

  filter {
    name   = "name"
    values = [var.ami_name_pattern]  
  }

  filter {
    name   = "virtualization-type"
    values = [var.virtualization_type] 
  }

  owners = var.ami_owners  
}

# Resource block for the EC2 instance's specific configuration
resource "aws_instance" "ec2" {
  ami                         = var.ec2_ami_id
  instance_type               = var.ec2_instance_type
  associate_public_ip_address = var.ec2_associate_public_ip_address
  monitoring                  = true
  key_name                    = var.ec2_key_name
  vpc_security_group_ids      = var.ec2_security_groups_ids
  disable_api_termination     = true
  availability_zone           = var.availability_zone

  credit_specification {
    cpu_credits = "standard"
  }

  root_block_device {
    volume_size = var.ec2_root_volume_size
    volume_type = var.ec2_root_volume_type
  }

  tags = {
    Name     = "EC2"
    Platform = var.ec2_tag_platform
    Type     = "Self-Managed"
  }
}
