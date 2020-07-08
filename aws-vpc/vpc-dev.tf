resource "aws_vpc" "Development" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy = "default"

  tags = {
    Name = "Dev"
    Location = "Belmont"
  }
}


