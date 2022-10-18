provider "aws" {

  region = "us-east-1"

}

resource "aws_instance" "ec2" {
  ami             = "ami-05fa00d4c63e32376"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.webtraffic.name]

  tags = {
    Name = "TerraformVPC"
  }
}

resource "aws_eip" "elasticip" {
  instance = aws_instance.ec2.id
}

output "EIP" {
  value = aws_eip.elasticip.public_ip
}

resource "aws_security_group" "webtraffic" {
  name = "Allow HTTPS"

  ingress = [{
    description = "Allow TCP traffic into webserver"
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }]

  egress = [{
    description = "Allow TCP traffic out of webserver"
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
  cidr_blocks = ["0.0.0.0/0"] }]

}
