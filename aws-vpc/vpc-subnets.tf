resource "aws_subnet" "dev-subnet" {
  count = "${length(data.aws_availability_zones.avail_zones.names)}"
  availability_zone = "${element(data.aws_availability_zones.avail_zones.names,count.index)}"
  vpc_id = "${aws_vpc.Development.id}"
  cidr_block = "${element(var.subnet_cidr,count.index)}"

  tags = {
    Name = "Subnet-${count.index+1}"
  }
}

