output "freddy_public_ip" {
  value = aws_instance.freddy.public_ip
}
output "nemo_public_ip" {
  value = aws_instance.nemo.public_ip
}
