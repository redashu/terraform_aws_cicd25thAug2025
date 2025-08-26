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
      Name = "ashu-public-subnet"
    }
  
}

# Creating private subnet 

resource "aws_subnet" "private_example" {
    vpc_id = aws_vpc.example.id
    cidr_block = var.private-sb-addr
    # above line is gonna auto assign public ip to vms
    tags = {
      Name = "ashu-private-subnet"
    }
  
}

