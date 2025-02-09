
output "vpc-id" {
  value = aws_vpc.terra-vpc.id
}
output "web-subnet-id" {
  value = aws_subnet.tf-web-subnet.id
}

output "app-subnet-id" {
  value = aws_subnet.tf-app-subnet.id
}

output "db-subnet-id" {
  value = aws_subnet.tf-db-subnet.id
}