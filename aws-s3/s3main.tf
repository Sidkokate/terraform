terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.84.0"
    }
     random = {
      source = "hashicorp/random"
      version = "3.6.3"
    }
  }
}

provider "aws" {
  region     = "ap-south-1"
}

resource "random_id" "rand_id" {
  byte_length = 8
}

resource "aws_s3_bucket" "demobuk" {
  bucket = "domobuk${random_id.rand_id.hex}"
}

resource "aws_s3_object" "data" {
  bucket = aws_s3_bucket.demobuk.bucket
  source = "./my.txt"
  key    = "mydata.txt"
}

output "name" {
  value = random_id.rand_id.hex
}