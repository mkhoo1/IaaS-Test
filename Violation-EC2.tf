provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}

data "aws_caller_identity" "current" {}

resource "aws_instance" "EC2Instance" {
  ami             = "ami-0d2692b6acea72ee6"
  instance_type   = "t2.micro"
  security_groups   = ["${aws_security_group.securityGroup.id}"]

  tags = {
    "key"       = "Name"
    "value"     = "shift-left"
  }
}

resource "aws_security_group" "securityGroup" {
  name          = "allow_tls"
  description   = "Allow TLS inbound traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }
}