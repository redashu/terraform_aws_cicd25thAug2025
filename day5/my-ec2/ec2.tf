
provider "aws" {
  # Configuration options
  # my terraform target region to provision resources 
  # calling variables
  region = "us-east-1"
  # access_key = ""
  # secret_key = ""
}

# to use any existing code based without rewrinting it we use module
module "myvpc" {
    source = "../vpc"
    vpc_cidr = "172.16.0.0/16"
    public_subnet_cidr = "172.16.1.0/24"
    private_subnet_cidr = "172.16.2.0/24"
    region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type = "t2.micro"

  subnet_id = module.myvpc.public_subnet_id

  tags = {
    Name = "MyExampleInstance"
  }
  
}