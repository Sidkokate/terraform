resource "aws_db_instance" "db-rds" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "root"
  password             = "Sid#k0kate07"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.mysub.name
}

resource "aws_db_subnet_group" "mysub" {
  name       = "main"
  subnet_ids = [var.app-subnet-id, var.db-subnet-id]

  tags = {
    Name = "My DB subnet group"
  }
}
#security group-----------------------------------------------------
resource "aws_security_group" "Tf-db-sg" {
  name        = "Tf-db-SG"
  description = "security group using Terraform"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.1.1.0/24"]
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
    Name = "db-sg"
  }
}
