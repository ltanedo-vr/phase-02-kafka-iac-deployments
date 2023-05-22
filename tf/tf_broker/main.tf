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
  access_key = "AKIAYDNQ5SU22G27XLUH"
  secret_key = "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"
}

resource "aws_instance" "demo_instance" {
   
    ami = "ami-0889a44b331db0194"
    instance_type = "t2.micro"
    
    tags = {
        Name = "tf_broker"
          }
    
    user_data = "${file("install_broker.sh")}"
}