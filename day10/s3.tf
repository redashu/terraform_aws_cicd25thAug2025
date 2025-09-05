provider "aws" {
    region = "ap-south-1"
  
}
resource "aws_s3_bucket" "example" {
  bucket = "ashutoshhmy-tf-test-bucket1"
  

  tags = {
    Name        = "Mybuckets3ashu"
    Environment = "Dev"
  }
}