provider "aws" {
  region = var.region

}

variable "region" {
  type    = string
  default = "ap-south-1"

}

# call local module to create vpc 
# module "vpc" {
#   source          = "../modules/vpc"
#   vpc-name        = "ashu-vpcnew1"
#   vpc-network     = "172.16.0.0/16"
#   public-sb-addr  = "172.16.1.0/24"
#   private-sb-addr = "172.16.2.0/24"

# }

# calling global / github module of vpc 
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "ashu-vpc"
  cidr = "172.16.0.0/16"

  azs             = ["ap-south-1a"]
  private_subnets = ["172.16.1.0/24"]
  public_subnets  = ["172.16.2.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

# creating ec2 instance 

# resource "aws_instance" "example" {
#   ami           = "ami-0861f4e788f5069dd"
#   instance_type = "t3.micro"
#   subnet_id     = module.vpc.public_subnet_id
#   tags = {
#     Name = "ashutoshh-vm"
#   }

# }

# # output of ec2 
# output "public_IP" {
#   value = aws_instance.example.public_ip

# }

