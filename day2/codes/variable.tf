variable "aws-region-name" {
    type = string
    #default = "us-east-2"
  
}

variable "aws-ami" {
    type = string
    default = "ami-0b016c703b95ecbe4"
    description = "this is my aws ami id"
  
}

variable "aws-instances-size" {
    type = string
    #default = "t2.nano"
  
}

variable "aws-instance-name" {
    type = string
   default = "ashu-linux-vm1"
  
}