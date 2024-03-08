 # LIST OF VPC VARIABLES

variable "aws_region" {
    description = "value of region"
     type = string
     default = "ap-south-1"
}


variable "vpc-cidr_block" {
    description = "value of vpc-cidrblock"
     type = string
     default = "10.0.0.0/16"
}

variable "sub1-cidr_block" {
    description = "value of sub1cidrblock"
     type = string
     default = "10.0.0.0/24"
}

variable "sub2-cidr_block" {
    description = "value of sub2cidrblock"
     type = string
     default = "10.0.1.0/24"
}

variable "route-cidr_block" {
    description = "value of routecidrblock"
    type = string
    default = "0.0.0.0/0"
  
}




variable "availability_zone1" {
    description = "value of az1"
    type = string
  
}
variable "availability_zone2" {
    description = "value of az2"
    type = string
  
}

# S3 VARIABLE

 variable "s3buc" {
    description = "value of s3bucket"
    type = string
    default = "tifprojectbatch2memb"
       
 }
 
 variable "dynamodbt" {
    description = "value of dynamodb"
    type = string
    default = "statelock"
   
 }

 # EC2 INSTANCE

 variable "ami_value" {
    description = "value of ami"
    type = string
    default = "ami-03bb6d83c60fc5f7c"
   
 }

 variable "instance_type" {}
 variable "key_name" {}

