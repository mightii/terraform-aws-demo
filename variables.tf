variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-west-1"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "demo"
}

variable "ami_id" {
  description = "AMI ID for EC2 instance (Amazon Linux 2 on eu-west-1)"
  type        = string
  default     = "ami-0905a3c97561e0b69"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}
