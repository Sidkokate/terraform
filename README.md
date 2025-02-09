# terraform
terraform : it is open source (iac) tool that allow you to manage infrastructure with configuration file rather than through a graphical user interface.
why terraform : we only define state (eg..os , cloud platform, ram ,etc) and its done . 
iac allows you to build ,change ,and manage your infra in safe ,consistent ,and reusability

its formate is HCL hashicorp config language : declarative , state management
it alloy json also
terraform init --> plan --> apply


# install aws cli
msiexec.exe /i https://awscli.amazonaws.com/AWSCLIV2.msi /qn
aws --version

# download terraform 
from hashicorp terraform site download terraform add path to environment variable



create access key in aws --> usecase cli 

.env
setx AWS_ACCESS_KEY_ID=ASDKDNFARG
setx AWS_SECRET_ACCESS_KEY_ID=MASFMAIEKANEIKGNNAVKRJVN
setx AWS_DEFAULT_REGION=ap-south-1


source .env orr . .\.env   ===execute .env file  give tmp aws access 
aws iam list-users

create main.tf file
terraform init
terraform plan
terraform apply
terraform destroy
terraform validate


we can create variables also 
and we can create saprate file for evry block eg.provider ,variable sitll it works

 variable "resion1" {description ="val of resion" type = "string" default ="ap-south-1" }
provider {resion = var.resion1}

output block to get some value as output 

random provider to create ramdom id for resorces 

we store our source terraform.state on remote server mostly

backend file to for terraform


create index.html ,style.css and mian.tf 
# with terraform 
provider configuration : aws and randome provider
bucket creation : s3 bucket with unic name
public access: configtarion public acces to bucket 
web configuration : setup bucket for static website hosting
file uplode on s3 : index.html ,css ,error file
output website endpoint
  
main.tf



manual create s3 bucket with policy 
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::webofsid/*"
        }
    ]
}

and the uplode html and css page in bucket

