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


# keyword , name_of_lib , object
resource "aws_instance" "ashu-name" {
  ami = "ami-0b016c703b95ecbe4"
  instance_type = "t2.nano"
  
}