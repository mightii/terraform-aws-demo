output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.demo.id
}

output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = module.app_server.public_ip
}

output "ec2_instance_id" {
  description = "Instance ID of the EC2"
  value       = module.app_server.instance_id
}
