terraform {
  backend "s3" {
       bucket = "tifprojectbatch2memb"
       region = "ap-south-1"
       key = "sharan/terraform.tfstate"
       #dynamodb_table = "statelock"

    
    
  }
}


