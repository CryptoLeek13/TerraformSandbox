provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "exampleec2" {
  ami                    = "ami-0e83be366243f524a"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.terraform-example-sg.id]
  user_data              = <<-EOF
              #!/bin/bash
              echo "Hello, Malik" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  user_data_replace_on_change = true


  tags = {
    Name = "Terraform-Example-EC2"
  }
}

resource "aws_security_group" "terraform-example-sg" {
  name = "terraform-example-sg"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
