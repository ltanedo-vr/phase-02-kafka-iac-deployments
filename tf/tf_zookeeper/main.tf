terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
}

resource "aws_instance" "demo_instance" {
   
    ami = "ami-0889a44b331db0194"
    instance_type = "t2.micro"
    
    tags = {
        Name = "tf_zookeeper"
          }
    
    user_data = "${file("install_zoo.sh")}"
}