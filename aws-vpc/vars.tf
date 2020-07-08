variable "region" {
  default = "us-west-1"
}

variable "vpc_cidr" {
  default = "172.18.0.0/16"
}

variable "subnet_cidr" {
  type = "list"
  default = ["172.18.10.0/24","172.18.20.0/24","172.18.30.0.0/24"]
}

variable "ec2_nemo_ip" {
  default = "172.18.10.105"
}

variable "ec2_freddy_ip" {
  default = "172.18.10.110"
}

data "aws_availability_zones" "avail_zones" {}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
