variable "aws-region-name" {
    type = string
    description = "region where i want to create VPC"
  
}

variable "vpc_id" {
    type = string
    description = "this my us-east-2 default vpc id"
  
}

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



# refering existing vpc 

data "aws_vpc" "my-vpc" {
    id = var.vpc_id

}

# refering existing vpc 

data "aws_vpc" "my-vpc" {
    id = var.vpc_id

}

# creating security group 
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = data.aws_vpc.my-vpc.id

  tags = {
    Name = "ashu-securit-grouptf"
  }
}

# Ingress rule 
resource "aws_vpc_security_group_ingress_rule" "example-ssh" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# port 80 also 

resource "aws_vpc_security_group_ingress_rule" "example-http" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

# egress rule to everywhere 

resource "aws_vpc_security_group_egress_rule" "example-all-ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "example-allipv6" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}





#output section 

# priting vpc id 

output "my-vpc-id" {
    value = data.aws_vpc.my-vpc.id
  
}

# my security group detail 

output "my-securitygroup" {
    value = "my security group name is ${aws_security_group.allow_tls.name}"
  
}