variable "my_ami" {
  type    = string
  default = "ami-085ad6ae776d8f09c"
}
variable "instance" {
    type = string
    default = "t2.micro"
}
variable "vpc_id" { }
variable "app-subnet-id" { }
variable "db-subnet-id" { }
