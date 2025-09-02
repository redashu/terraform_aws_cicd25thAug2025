# terraform_aws_cicd25thAug2025

### Revision about Terragrunt 

<img src="tr1.png">

## creating directory structure and using it with terragrunt 

```
mkdir  day7-terragrunt
ls day7-terragrunt/
root.hcl

===root.hcl content 

# Root Terragrunt: global settings like remote state
remote_state {
  backend = "s3"
  config = {
    bucket         = "ashubackstores111"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "ashu-lock-table1"
    encrypt        = true
  }
}

# Optional: global locals
locals {
  company = "ashu-inc"
}

```

### few changes 

```
 
[ec2-user@ip-172-31-41-146 ashu-codes]$ cd day7-terragrunt/
[ec2-user@ip-172-31-41-146 day7-terragrunt]$ ls
root.hcl
[ec2-user@ip-172-31-41-146 day7-terragrunt]$ 
[ec2-user@ip-172-31-41-146 day7-terragrunt]$ 
[ec2-user@ip-172-31-41-146 day7-terragrunt]$ mkdir  infra-module infra-live
[ec2-user@ip-172-31-41-146 day7-terragrunt]$ ls
infra-live  infra-module  root.hcl
[ec2-user@ip-172-31-41-146 day7-terragrunt]$ 
[ec2-user@ip-172-31-41-146 day7-terragrunt]$ mv root.hcl   infra-live/
[ec2-user@ip-172-31-41-146 day7-terragrunt]$ ls
infra-live  infra-module
[ec2-user@ip-172-31-41-146 day7-terragrunt]$ ls  infra-live/
root.hcl
[ec2-user@ip-172-31-41-146 day7-terragrunt]$ 

```
### creating module directory 

```
mkdir  infra-module/vpc
[ec2-user@ip-172-31-41-146 day7-terragrunt]$ mkdir  infra-module/ec2
[ec2-user@ip-172-31-41-146 day7-terragrunt]$ touch infra-module/vpc/main.tf
[ec2-user@ip-172-31-41-146 day7-terragrunt]$ touch infra-module/ec2/main.tf
[ec2-user@ip-172-31-41-146 day7-terragrunt]$ 

```
### vpc/main.tf

```
terraform {
  backend "s3" {}
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR block for the public subnet"
}

variable "region" {
  type        = string
  description = "AWS region"
}

provider "aws" {
  region = var.region
}

# VPC
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "demo-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "demo-igw"
  }
}

# Public Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = "${var.region}a"

  tags = {
    Name = "demo-public-subnet"
  }
}

# Route Table for Public Subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "demo-public-rt"
  }
}

# Route Table Association
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Outputs
output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

```