resource "aws_internet_gateway" "terraform-gw" {
  vpc_id = "${aws_vpc.Development.id}"

  tags = {
    Name = "Dev"
  }
}
