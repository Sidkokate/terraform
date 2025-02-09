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
##pem-key--------------------------------------------------------------------
# resource "aws_key_pair" "tf-key-pair" {
#     key_name = "terra-key"
#     public_key = tls_private_key.rsa.public_key_openssh
# }
# resource "tls_private_key" "rsa" {
#     algorithm = "RSA"
#     rsa_bits  = 4096
# }
# resource "local_file" "tf-key" {
#    content  = tls_private_key.rsa.private_key_pem
#    filename = "terra-key.pem"
# }

##output-----------------------------------------------------------------------
# output "aws_instance_public_ip" {
#   value = aws_instance.myserver.public_ip
# }

## sg group------------------------------------------------------------------------
# resource "aws_security_group" "TF_SG" {
#   name        = "Terraform"
#   description = "security group using Terraform"
#   vpc_id      = "vpc-00cd0ad0a7eccef87"

#   ingress {
#     description      = "HTTP"
#     from_port        = 80
#     to_port          = 80
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   ingress {
#     description      = "SSH"
#     from_port        = 22
#     to_port          = 22
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   tags = {
#     Name = "TF_SG"
#   }
# }