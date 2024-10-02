# This output will be used to configure the security groups and to connect the ec2 instance into.
output "vpc_id" {
  value = aws_vpc.my_vpc.id
}
