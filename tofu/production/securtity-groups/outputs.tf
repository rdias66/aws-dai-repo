// Output the Security Group IDs for reference and potential use in other modules

output "ec2_sg_id" {
  description = "The security group ID for EC2"
  value       = aws_security_group.ec2_sg.id
}

output "ec2_rds_sg_id" {
  description = "The security group ID for EC2 to RDS communication"
  value       = aws_security_group.ec2_rds_sg.id
}

output "rds_ec2_sg_id" {
  description = "The security group ID for RDS to EC2 communication"
  value       = aws_security_group.rds_ec2_sg.id
}
