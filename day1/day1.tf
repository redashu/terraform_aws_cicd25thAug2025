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
  region = "us-east-2"
  # access_key = ""
  # secret_key = ""
}

# creating ec2 instance 
# keyword , name_of_lib , object
resource "aws_instance" "ashu-name" {
  ami = "ami-0b016c703b95ecbe4"
  instance_type = "t2.nano"
  key_name = aws_key_pair.example.key_name

  tags = {
    Name = "ashu-linux-vm1"
  }
  
}

# use use manual key-pair to create in aws

# creating key pair using terraform internal resource 

# RSA key of size 4096 bits
resource "tls_private_key" "ashu-example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# use above to put public in ec2 
resource "aws_key_pair" "example" {
  key_name = "ashu-key"
  #public_key = file("/home/ec2-user/.ssh/ashu-key.pub")
  public_key = tls_private_key.ashu-example.public_key_openssh
  
}

# incase you want to save private key as well
resource "local_file" "ashu-private-key" {
  content  = tls_private_key.ashu-example.private_key_pem
  filename = "${path.module}/ashu-privateKey.pem"
  file_permission = "0400"
}
