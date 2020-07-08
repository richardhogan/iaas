provider "aws" {
  region     = "${var.region}"
}

resource "aws_key_pair" "admin-key" {
  key_name   = "admin-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDExn4D9nkT/jMe+fLm7NtIVzL+u/T0rN6zyr4aNCOmAvYjkGYunzVUDBnxdhXB8jj9kyzJQB3zG5P2qLdO/7KllVHA0lrqgaZPRk2olwcYeioPKQ/u95JwG4/SckOWgIusnn/N01jPR25HwfVtJXANYmKHcVjYKoY4rxmI0/ZcbXgVj6gyPCB71gUeFVkGKustYubbW15XEKW33TBesl621Ltobxr1cDoUNtpE1WWgS4fCwPWepuRYJmeV557Dt9dElsxd6+iYEdwtKSlN55wnYQEePIj76+8QKtkAJu4N/nG+hyzHSzDSiSpfg+kmWR8DOUnfiIe1IKjNmjDaMv6SWFDcg2Pmc1DevXBP9PkzlGg0MBWXHTTel+2ciSU1V2j6Lw7T0khuRB76ARPTMR9XQr04balsczQdy/1xZf5fZ5l6E6ZQWSXbw0BdSt6pf89/Y348HW7ygAn4diZwC3qBtwWh44E8um7aV7pvJpPw/SiHAWYfKvSM5G+4u5DwWk3kZJYiL5uZj+Bo/EIGFdwjKVwAnrYUwC3pRZsT5baI+ec4HavPJ6646R8KIYBOXWA3IEKsywEGNPEFJHlGXm2qMG6cIPJ34/m2dbo2uGBx737si46YC3IFJGh/nqVcbx01pBiCGGsIm0HIt74BCyFJhV0eIQCblYIs412bj7dyew== rich.hogan@richhogan-0349L.local"
}

resource "aws_network_interface" "eth0" {
  subnet_id   = "${aws_subnet.dev-subnet[0].id}"
  private_ips = ["172.18.10.101"]

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "nemo" {
  vpc_security_group_ids = ["${aws_security_group.allow-ssh.id}"]
  ami           = "ami-0dd655843c87b6930"  # Ubuntu 18.04 (Bionic) - US West 1
  instance_type = "t2.micro"
  key_name = "admin-key"
  subnet_id = "${aws_subnet.dev-subnet[0].id}"
  private_ip = "${var.ec2_nemo_ip}"
  associate_public_ip_address = "true"

  tags = {
    Name = "nemo"
    Type = "Database"
  }
}

resource "aws_instance" "freddy" {
  vpc_security_group_ids = ["${aws_security_group.allow-ssh.id}"]
  ami           = "${element(data.aws_ami.ubuntu[0].id,count.index)}"  # Ubuntu 18.04 (Bionic) - US West 1
#  ami           = "ami-0dd655843c87b6930"  # Ubuntu 18.04 (Bionic) - US West 1
  instance_type = "t2.micro"
  key_name = "admin-key"
  subnet_id = "${aws_subnet.dev-subnet[0].id}"
  private_ip = "${var.ec2_freddy_ip}"
  associate_public_ip_address = "true"

  tags = {
    Name = "freddy"
    Type = "NGINX Controller"
  }
}
