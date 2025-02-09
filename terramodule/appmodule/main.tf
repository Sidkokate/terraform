
resource "aws_instance" "app-ec2" {
  subnet_id       = var.app-subnet-id
  ami             = var.my_ami
  instance_type   = var.instance
  vpc_security_group_ids = [aws_security_group.Tf-app-sg.id]
    associate_public_ip_address = false
  key_name = "terra-key"
  tags = {
    Name = "app-instance"
  }
}
#security group-----------------------------------------------------

resource "aws_security_group" "Tf-app-sg" {
  name        = "Tf-app-SG"
  description = "security group using Terraform"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "app-sg"
  }
}
