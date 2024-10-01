# The output value named "address" is defined here.
output "address" {
  value = aws_instance.ec2.*.public_dns
  description = "Returns the created instance's public DNS address"
  # The "value" attribute specifies what will be returned as part of the output.
  # In this case, it's using the AWS EC2 instance resource named "ec2".
  # The ".*" syntax is used to retrieve the public DNS names of all EC2 instances created.
  
  # "public_dns" provides the public DNS address for each EC2 instance.
  # This is especially useful for accessing your EC2 instances over the internet.
  
  # If you have multiple instances, this will return a list of their public DNS addresses.
  # If there is only one instance, it will return that instance's public DNS address as a single item.
  
  # Outputs can be viewed after running `terraform apply`, and they can also be used in other modules
}
