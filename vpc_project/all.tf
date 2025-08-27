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

variable "aws-ami" {
    type = string
    description = "this is my aws ami id"
  
}

variable "aws-instances-size" {
    type = string
  
}

variable "aws-instance-name" {
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

# association of route table with public subnet

resource "aws_route_table_association" "example" {
  subnet_id = aws_subnet.public_example.id
  route_table_id = aws_route_table.example.id
  
}

# for NAT gw -- creating EIP

resource "aws_eip" "example" {
  domain   = "vpc"
}

# Creating natGW using EIP also interface in public subnet

resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.example.id
  subnet_id = aws_subnet.public_example.id

  tags = {
    Name = "${var.vpc-name}-natgw"
  }
  # optional but sometimes to check limits and condition good to put
  depends_on = [ aws_internet_gateway.example ]
}

# creating routing table for private subnet using NATgw 

resource "aws_route_table" "example-private" {
  vpc_id = aws_vpc.example.id
  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.example.id
  }
  
  tags = {
    Name = "${var.vpc-name}-privateRoute-table"
  }

}

# association with private subnet 

resource "aws_route_table_association" "example-private" {
  subnet_id = aws_subnet.private_example.id
  route_table_id = aws_route_table.example-private.id
  
}

# creating ec2 isntance in public subnet

# RSA key of size 4096 bits
resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# use above to put public in ec2 
resource "aws_key_pair" "example" {
  key_name = "${var.aws-instance-name}-key"
  #public_key = file("/home/ec2-user/.ssh/ashu-key.pub")
  public_key = tls_private_key.example.public_key_openssh
  
}

# incase you want to save private key as well
resource "local_file" "ashu-private-key" {
  content  = tls_private_key.example.private_key_pem
  filename = "${path.module}/ashu-privateKey.pem"
  file_permission = "0400"
}

# creating security group 

resource "aws_security_group" "example" {
  name        = "${var.aws-instance-name}-securityGroup"
  description = "Allow 22 (ssh) and http (80) as incoming connection"
  vpc_id      = aws_vpc.example.id

  tags = {
    Name = "${var.aws-instance-name}-securityGroup"
  }
}

# Ingress rule 
resource "aws_vpc_security_group_ingress_rule" "example-ssh" {
  security_group_id = aws_security_group.example.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# egress rule to everywhere 

resource "aws_vpc_security_group_egress_rule" "example-all-ipv4" {
  security_group_id = aws_security_group.example.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "example-allipv6" {
  security_group_id = aws_security_group.example.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
# creating ec2 
resource "aws_instance" "example" {
  ami = var.aws-ami
  instance_type = var.aws-instances-size
  key_name = aws_key_pair.example.key_name
  subnet_id = aws_subnet.public_example.id
  # association of security group
  vpc_security_group_ids = [aws_security_group.example.id]

  tags = {
    Name = var.aws-instance-name
  }
  
}
