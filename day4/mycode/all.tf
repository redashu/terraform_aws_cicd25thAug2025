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

# creating ec2

# RSA key of size 4096 bits
resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# use above to put public in ec2 
resource "aws_key_pair" "example" {
  key_name = "ashu111-key"
  #public_key = file("/home/ec2-user/.ssh/ashu-key.pub")
  public_key = tls_private_key.example.public_key_openssh
  
}

# incase you want to save private key as well
resource "local_file" "ashu-private-key" {
  content  = tls_private_key.example.private_key_pem
  filename = "${path.module}/ashu-privateKey.pem"
  file_permission = "0400"
}

# creating ec2 
resource "aws_instance" "example" {
  ami = var.aws-ami
  instance_type = var.aws-instances-size
  key_name = aws_key_pair.example.key_name
  # association of security group
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  depends_on = [ local_file.ashu-private-key ]

  tags = {
    Name = "ashu-vmlinux"
  }
  # file provisioner to transfer data from terraform machine to remote 
  provisioner "file" {
    source = "./html-sample-app"
    destination = "/tmp/"
    
  }
  # remote provisioner 
  provisioner "remote-exec" {
    inline = [ 
        "mkdir  -p  ~/ashu/data/webapp",
        "sudo yum install httpd git -y ",
        "sudo cp -rf /tmp/html-sample-app/* /var/www/html/",
        "sudo systemctl start httpd"
     ]
     
  }
  # defining connection details 
     connection {
        type = "ssh"
        user = "ec2-user"
        timeout = "3m"
        host = self.public_ip
        #private_key = aws_key_pair.example.key_name
        private_key = file("/home/ec2-user/ashu-codes/day4-code/ashu-privateKey.pem")
       
     }
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

resource "local_file" "example" {
  content  = "my vpc id IS ${data.aws_vpc.my-vpc.id}"
  filename = "${path.module}/vpc_id.txt"
}