# PLZ do not use as it change names and other understood details 
# plz create terrafrom.tfvars file with required values
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.10.0"
    }
  }
  backend "s3" {
    # make sure bucket is already there 
    bucket = "ashutoshh-terraform-state"
    key = "dev-env/terraform.tfstate"
    region = "us-east-2"
    encrypt = true
    acl = "private"
    # make sure dynamodb table is present 
    dynamodb_table = "ashu-terraform-table2"
    
  }

}

provider "aws" {
    region = var.region
      
}


variable "region" {}
variable "ami" {}
variable "type" {}
variable "vpc_exitingID" {
  type = string
}
variable "instance-number" {
    type = number
}
variable "aws-instance-name" {
}

variable "securitygroup" {
  
}

output "public_Ips" {
    value = aws_instance.example[*].public_ip
  
}

# creating ansible inventory like file 
resource "null_resource" "stop_ipaddress" {
  depends_on = [ aws_instance.example ]
  provisioner "local-exec" {
    command = <<EOT
      echo "[hello]" >ip.txt
      echo "${join("\n",aws_instance.example[*].public_ip)}" >>ip.txt
      EOT   
  }
  
}

# storing ips 
resource "local_file" "example_ips" {
  content = join("\n",aws_instance.example[*].public_ip)
  filename = "${path.module}/ec2_ips.txt"
  
}


data "aws_vpc" "example" {
  id = var.vpc_exitingID
}

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
  depends_on = [ tls_private_key.example ]
  
}

# incase you want to save private key as well
resource "local_file" "ashu-private-key" {
  content  = tls_private_key.example.private_key_pem
  filename = "${path.module}/ashu-privateKey.pem"
  file_permission = "0400"
  depends_on = [ aws_key_pair.example ]
}

# security group 
resource "aws_security_group" "allow_tls" {
  name        = var.securitygroup
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = data.aws_vpc.example.id

  tags = {
    Name = "ashu-security-groupnew"
  }
}
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv480" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv422" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}


resource "aws_instance" "example" {
  ami = var.ami
  instance_type = var.type
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  count = var.instance-number
  tags = {
    Name = "${var.aws-instance-name}-${count.index}"
  }
  key_name = aws_key_pair.example.key_name
  depends_on = [ aws_key_pair.example,aws_security_group.allow_tls ]
  
}
