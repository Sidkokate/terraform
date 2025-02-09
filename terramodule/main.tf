
#aws_key_pair-------------------------------------------------------------------
resource "aws_key_pair" "tf-key-pair" {
  key_name   = "terra-key"
  public_key = tls_private_key.rsa.public_key_openssh
}
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "tf-key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "terra-key.pem"
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
#modules--------------------------------------------------------
module "vpcmodule" {
  source = "./vpcmodule"
}

module "webmodule" {
  source        = "./webmodule"
  vpc_id        = module.vpcmodule.vpc-id
  web-subnet-id = module.vpcmodule.web-subnet-id
}
module "appmodule" {
  source        = "./appmodule"
  vpc_id        = module.vpcmodule.vpc-id
  app-subnet-id = module.vpcmodule.app-subnet-id
  db-subnet-id  = module.vpcmodule.db-subnet-id


}
module "dbmodule" {
  source        = "./dbmodule"
  vpc_id        = module.vpcmodule.vpc-id
  app-subnet-id = module.vpcmodule.app-subnet-id
  db-subnet-id  = module.vpcmodule.db-subnet-id
}
