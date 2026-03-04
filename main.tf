terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}


# VPC
resource "aws_vpc" "demo" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name        = "vpc-terraform-demo"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Subnet public
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.demo.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name      = "subnet-public-demo"
    ManagedBy = "Terraform"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "demo" {
  vpc_id = aws_vpc.demo.id

  tags = {
    Name      = "igw-demo"
    ManagedBy = "Terraform"
  }
}

# Security Group
resource "aws_security_group" "demo" {
  name = "demo-security-group"
  description = "Security group for demo EC2"
  vpc_id      = aws_vpc.demo.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "sg-demo"
    ManagedBy = "Terraform"
  }
}

# EC2 Instance
module "app_server" {
  source  = "app.terraform.io/Demo_Terraform_Manu/ec2-instance/aws"
  version = "1.0.1"

  name               = "ec2-terraform-demo"
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  subnet_id          = aws_subnet.public.id
  security_group_ids = [aws_security_group.demo.id]
}
