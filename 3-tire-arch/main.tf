#variables--------------------------------------------------------------------- 
variable "my_region" {
  type    = string
  default = "ap-south-1"
}

variable "my_access_key" {
  type    = string
  default = "YOUR_ACCESS_KEY"
}
variable "my_secret_key" {
  type    = string
  default = "YOUR_SECRET_KEY"
}

variable "my_ami" {
  type    = string
  default = "ami-085ad6ae776d8f09c"
}

# required_version-----------------------------------------
terraform {
  required_version = "~> 1.1"
  required_providers {
    aws = {
      version = "~>3.1"
    }
  }
}
provider "aws" {
  region     = var.my_region
  access_key = var.my_access_key
  secret_key = var.my_secret_key
}

#aws_inctance
resource "aws_instance" "web-ec2" {
  subnet_id       = aws_subnet.tf-web-subnet.id
  ami             = var.my_ami
  instance_type   = "t2.micro"
  vpc_security_group_ids = [aws_security_group.Tf-web-sg.id]
  key_name = "terra-key"
  associate_public_ip_address = true
  tags = {
    Name = "web-instance"
  }
  user_data = <<-EOF
  #!/bin/bash
  yum update -y
  yum install nginx -y
  service nginx start
  echo "habibi ho gai" > /usr/share/nginx/html/index.html
  EOF

}

resource "aws_instance" "app-ec2" {
  subnet_id       = aws_subnet.tf-app-subnet.id
  ami             = var.my_ami
  instance_type   = "t2.micro"
  vpc_security_group_ids = [aws_security_group.Tf-app-sg.id]
    associate_public_ip_address = false
  key_name = "terra-key"
  tags = {
    Name = "app-instance"
  }
}
#aws_db_instance----------------------------------------------------------------------
resource "aws_db_instance" "db-rds" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "root"
  password             = "Sid#k0kate07"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.mysu.name
}

resource "aws_db_subnet_group" "mysu" {
  name       = "main"
  subnet_ids = [aws_subnet.tf-app-subnet.id, aws_subnet.tf-db-subnet.id]

  tags = {
    Name = "My DB subnet group"
  }
}

output "public_ip" {
  value = aws_instance.web-ec2.public_ip
}
