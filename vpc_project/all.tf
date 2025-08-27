# provider section 
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.10.0"
    }
  }
}

provider "aws" {
  # Configuration options
  # my terraform target region to provision resources 
  # calling variables
  region = var.aws-region-name
  # access_key = ""
  # secret_key = ""
}

# variables section
variable "aws-region-name" {
    type = string
    description = "region where i want to create VPC"
  
}

variable "vpc-network" {
    type = string 
}

variable "vpc-name" {
    type = string
  
}

variable "public-sb-addr" {
    type = string
  
}

variable "private-sb-addr" {
    type = string
  
}

# main section
# step 1  create VPC 
# step 1  create VPC 
resource "aws_vpc" "example" {
    cidr_block = var.vpc-network
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
      Name = var.vpc-name
    }
  
}

# step 2 creating public subnet 
resource "aws_subnet" "public_example" {
    vpc_id = aws_vpc.example.id
    cidr_block = var.public-sb-addr
    map_public_ip_on_launch = true 
    # above line is gonna auto assign public ip to vms
    tags = {
      Name = "${var.vpc-name}-public-subnet"
    }
  
}

# Creating private subnet 

resource "aws_subnet" "private_example" {
    vpc_id = aws_vpc.example.id
    cidr_block = var.private-sb-addr
    # above line is gonna auto assign public ip to vms
    tags = {
      Name = "${var.vpc-name}-private-subnet"
    }
  
}

# creating IGW 

resource "aws_internet_gateway" "example" {
    vpc_id = aws_vpc.example.id
    tags =  {
        Name = "${var.vpc-name}-igw"
    }
  
}

# creatig public route table

# Creating routing table of public subnet 

resource "aws_route_table" "example" {
  vpc_id = aws_vpc.example.id
  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example.id
  }
  
  tags = {
    Name = "${var.vpc-name}-publicRoute-table"
  }

}