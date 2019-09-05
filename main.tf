provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_key_pair" "ssh" {
  key_name = "${var.key}"
  public_key = "${file(var.public_key)}"
}

resource "aws_vpc" "k8s-vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "k8s-igw" {
  
}
