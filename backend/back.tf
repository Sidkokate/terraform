variable "resion1" {
  description = "val of resion"
  type        = string
  default      = "ap-south-1"
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.84.0"
    }
  }
  backend "s3" {
    bucket = "domobuk6ddf2ee91359d312"
    key = "backend.tfstate"
    region= "ap-south-1"
  }
}

provider "aws" {
    region = var.resion1
}

resource "aws_instance" "myserver" {
  ami = "ami-00bb6a80f01f03502"
  instance_type = "t2.micro"
  tags = {
    Name = "myserver"
  }
}