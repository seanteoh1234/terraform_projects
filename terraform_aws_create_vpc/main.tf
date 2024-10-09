terraform {
  required_providers {
    aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}

provider "aws" {
    region = var.region
}

resource "aws_vpc" "terraform_vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "tf-example"
  }
}

resource "aws_subnet" "terraform_subnet" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = var.availability_zone

  tags = {
    Name = "tf-example"
  }
}

data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.terraform_subnet.id

  tags = {
    Name = "tf-example"
  }
}