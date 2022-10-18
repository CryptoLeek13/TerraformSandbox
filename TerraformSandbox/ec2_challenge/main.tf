# Create a db server and output the private ip
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

resource "aws_instance" "db_server" {
  ami           = "ami-0f924dc71d44d23e2"
  instance_type = "t2.micro"

  tags = {
    Name = "DB Server"
  }
}
resource "aws_instance" "web_server" {
  ami             = "ami-0f924dc71d44d23e2"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.webtraffic.name]
  user_data       = file("server-script.sh")
  tags = {
    Name = "Web Server"
  }
}

resource "aws_eip" "web_ip" {
  instance = aws_instance.web_server.id
}

variable "ingress" {
  type    = list(number)
  default = [80, 443]
}

variable "egress" {
  type    = list(number)
  default = [80, 443]
}

resource "aws_security_group" "webtraffic" {
  name = "Allow Web Traffic"

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    iterator = port
    for_each = var.egress
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

output "PrivateIp" {
  value = aws_instance.db_server.private_ip

}

output "PublicIp" {
  value = aws_eip.web_ip.public_ip

}
