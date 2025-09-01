provider "aws" {
  region = var.region
  
}

variable "region" {
    type = string
    default = "ap-south-1"
  
}

# call module to create vpc 
module "vpc" {
    source = "../modules/vpc"
    vpc-name = "ashu-vpcnew1"
    vpc-network = "172.16.0.0/16"
    public-sb-addr = "172.16.1.0/24"
    private-sb-addr = "172.16.2.0/24"
  
}

# creating ec2 instance 

resource "aws_instance" "example" {
    ami = "ami-0861f4e788f5069dd"
    instance_type = "t2.nano"
    subnet_id = module.vpc.public_subnet_id
    tags = {
      Name = "ashutoshh-vm"
    }
  
}

# output of ec2 
output "public_IP" {
    value = aws_instance.example.public_ip
  
}

