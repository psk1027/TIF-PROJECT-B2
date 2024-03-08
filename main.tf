# CREATE VPC TO SECURE APPLICATION

resource "aws_vpc" "tf-jenkins" {
    cidr_block = var.vpc-cidr_block
        tags = {
            name = "tf-jenkins"
        }
  
}

#  CREATE INTERNETGATEWAY TO VPC TO CONNECT THE APPLICATION

resource "aws_internet_gateway" "myigw" {
    vpc_id = aws_vpc.tf-jenkins.id
        tags = {
            name = "tf-jenkins-igw"
        }
  
}


#  CREATE SUBNETS THROUGH VPC TO CONNECT THE APPLICATION

resource "aws_subnet" "mysub1" {
    vpc_id = aws_vpc.tf-jenkins.id
    cidr_block = var.sub1-cidr_block
     availability_zone = var.availability_zone1
     map_public_ip_on_launch = true
               tags = {
                 name = "tf-jen-sub1"
               }

}

resource "aws_subnet" "mysub2" {
    vpc_id = aws_vpc.tf-jenkins.id
    cidr_block = var.sub2-cidr_block
     availability_zone = var.availability_zone2
     map_public_ip_on_launch = true
               tags = {
                 name = "tf-jen-sub2"
               }

}

# CREATE ROUTE TABLE
resource "aws_route_table" "tf-jen-myrt" {
    vpc_id = aws_vpc.tf-jenkins.id
        route {
            cidr_block = var.route-cidr_block
            gateway_id = aws_internet_gateway.myigw.id
        }
        tags = {
          name = "tf-jen-rt"
        }

  
}

# CREATE ROUTE TABLE ASSOCIATION

resource "aws_route_table_association" "rta1" {
    route_table_id = aws_route_table.tf-jen-myrt.id
    subnet_id = aws_subnet.mysub1.id
  
}

resource "aws_route_table_association" "rta2" {
    route_table_id = aws_route_table.tf-jen-myrt.id
    subnet_id = aws_subnet.mysub2.id
  
}

# CREATE SECURITY GROUPS FOR VPC

resource "aws_security_group" "tf-jen-mysg" {
     name = "tf-jenkins"
     vpc_id = aws_vpc.tf-jenkins.id

     ingress = [ 
           {
              description = "HTTP"
               from_port = 8080
               to_port = 8080
               protocol = "tcp"
               prefix_list_ids = []
               security_groups = []
               self = false
               ipv6_cidr_blocks = ["::/0"]
               cidr_blocks = ["0.0.0.0/0"]
} ,
           {
               description = "SSH"
               from_port = 22
               to_port = 22
               protocol = "tcp"
               prefix_list_ids = []
               security_groups = []
               self = false
               ipv6_cidr_blocks = ["::/0"]
               cidr_blocks = ["0.0.0.0/0"]

           } 

     ]
        egress {
                  from_port = 0
                  to_port = 0
                  protocol = "-1"
                  cidr_blocks = ["0.0.0.0/0"]

        }  
           tags = {
             name = "tf-jen-sg"
           }
}

#  CREATE S3 BUCKET

data "aws_s3_bucket" "mys3b" {
   bucket = var.s3buc
       
       }

# CREATION OF DYNAMODB

/*resource "aws_dynamodb_table" "mydbt" {
    name = var.dynamodbt
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LOCK_ID"
      attribute {
         name = "LOCK_ID"
          type = "S"
      }
  
}*/







# CREATE EC2 INSTANCE

resource "aws_instance" "tf-jen1" {
    ami =  var.ami_value
    instance_type = var.instance_type
    key_name =  var.key_name
    subnet_id = aws_subnet.mysub1.id
    vpc_security_group_ids = [aws_security_group.tf-jen-mysg.id]
    user_data = base64encode(file("jenkins-install.sh"))
    

}


resource "aws_instance" "tf-jen2" {
    ami = var.ami_value
    instance_type = var.instance_type
    key_name =  var.key_name
    subnet_id = aws_subnet.mysub2.id
    vpc_security_group_ids = [aws_security_group.tf-jen-mysg.id]
    user_data = base64encode(file("jenkins-install1.sh"))

}




 