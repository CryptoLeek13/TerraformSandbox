provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "exampleec2" {
  ami           = "ami-0fa399d9c130ec923"
  instance_type = "t2.micro"

  tags = {
    Name = "Terraform-Example-EC2"
  }
}
