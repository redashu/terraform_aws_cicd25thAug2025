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

