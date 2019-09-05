provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_key_pair" "ssh" {
  key_name = "${var.key}"
  public_key = "${file(var.public_key)}"
}

resource "aws_vpc" "k8s_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "k8s_igw" {
  vpc_id = "${aws_vpc.k8s_vpc.id}"
}

resource "aws_route" "internet_access" {
  route_table_id = "${aws_vpc.k8s_vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.k8s_igw.id}"
}

resource "aws_subnet" "k8s_sub_1" {
  vpc_id = "${aws_vpc.k8s_vpc.id}"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_security_group" "k8s_sg" {
  vpc_id = "${aws_vpc.k8s_vpc.id}"

  ingress {
    from_port = 22
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "tcp"
  }

  egress { 
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "-1"
  }
}

resource "aws_spot_instance_request" "k8s-main" {
  ami = "${lookup(var.aws_amis, var.aws_region)}"
  instance_type = "t3.small"

  key_name = "${aws_key_pair.ssh.id}"

  vpc_security_group_ids = ["${aws_vpc.k8s_vpc.id}"]
  subnet_id = "${aws_subnet.k8s_sub_1.id}"
}
