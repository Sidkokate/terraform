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
}

provider "aws" {
    region = var.resion1
}

resource "aws_instance" "myserver" {
  ami = "ami-00bb6a80f01f03502"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.TF_SG.name]
  key_name = "terra-key"
  tags = {
    Name = "myserver"
  }
}