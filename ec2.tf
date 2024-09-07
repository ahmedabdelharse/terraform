data "aws_ami" "ubuntu22" {
  most_recent = true 
  owners = ["099720109477"] #Canonical
  filter {
    name = "name"
    values = ["*/ubuntu-jammy-22.04-amd64-server-*"]
  }  
}

resource "aws_instance" "tf-pub-ec2" {
  ami             = data.aws_ami.ubuntu22.id
  subnet_id       = aws_subnet.tf_public_subnet.id
  instance_type   = "t2.micro"
  key_name        = "ahmed-tf-test"
  security_groups = [aws_default_security_group.tf-sg.id]
  associate_public_ip_address = true
  tags = {
    Name = "tf-pup-ec2"
  }
}

resource "aws_instance" "tf-prv-ec2" {
  ami             = data.aws_ami.ubuntu22.id
  subnet_id       = aws_subnet.tf_private_subnet.id
  instance_type   = "t2.micro"
  key_name        = "ahmed-tf-test"
  
  security_groups = [aws_default_security_group.tf-sg.id]
  tags = {
    Name = "tf-prv-ec2"
  }
}