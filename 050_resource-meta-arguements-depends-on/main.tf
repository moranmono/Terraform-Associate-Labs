terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.58.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "eu-central-1"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "08697da0e8d9f59ec-depends-on"
}

resource "aws_instance" "my_server" {
  ami           = "ami-08697da0e8d9f59ec"
  instance_type = "t3.micro"
	depends_on = [
		aws_s3_bucket.bucket
	]
}

output "public_ip" {
  value = aws_instance.my_server.public_ip
}