resource "aws_vpc" "terra-vpc" {
  cidr_block       = "10.1.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Tf-vpc"
  }
}
#subnet--------------------------------------------------
resource "aws_subnet" "tf-web-subnet" {
  vpc_id            = aws_vpc.terra-vpc.id
  cidr_block        = "10.1.0.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "web-subnet"
  }
}
resource "aws_subnet" "tf-app-subnet" {
  vpc_id            = aws_vpc.terra-vpc.id
  cidr_block        = "10.1.1.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "app-subnet"
  }
}
resource "aws_subnet" "tf-db-subnet" {
  vpc_id            = aws_vpc.terra-vpc.id
  cidr_block        = "10.1.2.0/24"
  availability_zone = "us-east-1c"
  tags = {
    Name = "db-subnet"
  }
}

#internet getway---------------------------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.terra-vpc.id

  tags = {
    Name = "tf-igw"
  }
}

#natgetway--------------------------------------------------------
# resource "aws_eip" "EIP" {
#   vpc = true
#   tags = {
#     Name = "nat-eip"
#   }
# }

# resource "aws_nat_gateway" "nat" {
#   allocation_id = aws_eip.EIP.id
#   subnet_id     = aws_subnet.tf-web-subnet.id
#   tags = {
#     Name = "nat-gway"
#   }
# }


#rout-table-----------------------------------------------------------
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.terra-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table" "privet-rt" {
  vpc_id = aws_vpc.terra-vpc.id
  tags = {
    Name = "privet-rt"
  }
}

#aws_route_table_association---------------------------------------------------
resource "aws_route_table_association" "web-assoc" {
  subnet_id      = aws_subnet.tf-web-subnet.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "app-assoc" {
  subnet_id      = aws_subnet.tf-app-subnet.id
  route_table_id = aws_route_table.privet-rt.id
}

resource "aws_route_table_association" "db-assoc" {
  subnet_id      = aws_subnet.tf-db-subnet.id
  route_table_id = aws_route_table.privet-rt.id
}