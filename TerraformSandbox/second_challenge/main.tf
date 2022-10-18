terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.32.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "ec2" {
  ami             = "ami-0f924dc71d44d23e2"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.webtraffic.name]

}

resource "aws_security_group" "webtraffic" {
  name = "Allow HTTPS"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
