output "puplic-ec2-ip-address" {
      value = aws_instance.tf-pub-ec2.public_ip
}