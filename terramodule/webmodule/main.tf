
#aws_inctance
resource "aws_instance" "web-ec2" {
  subnet_id       = var.web-subnet-id
  ami             = var.my_ami
  instance_type   = var.instance
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
#security group-----------------------------------------------------
resource "aws_security_group" "Tf-web-sg" {
  name        = "Tf-web-SG"
  description = "security group using Terraform"
  vpc_id      = var.vpc_id

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
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
    Name = "web-sg"
  }
}
