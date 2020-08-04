resource "aws_security_group" "allow-ssh" {
  name = "allow-ssh"
  vpc_id = "${aws_vpc.Development.id}"

  # SSH access into the VPC
  ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

# Standard HTTP access into the VPC (open internet)
  ingress {
    description = "HTTP into VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

# Secure HTTP over TLS access into the VPC (open internet)
  ingress {
    description = "HTTP/S into VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

# Scrolllog UI access into the VPC (open internet)
  ingress {
    description = "Scrolllog UI into VPC"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

# GraphQL UI access from outside VPC (open internet)
  ingress {
    description = "TLS from VPC"
    from_port   = 4000
    to_port     = 4000
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

 # Allow all external access from the VPC
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
