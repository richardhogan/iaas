resource "aws_route_table" "r" {
  vpc_id = "${aws_vpc.Development.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.terraform-gw.id}"
  }
}

resource "aws_main_route_table_association" "a" {
  vpc_id         = "${aws_vpc.Development.id}"
  route_table_id = "${aws_route_table.r.id}"
}
