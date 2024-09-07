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
  instance_type   = var.instance_type
  key_name        = aws_key_pair.ssh-key.key_name
  availability_zone = var.a_z
  security_groups = [aws_default_security_group.tf-sg.id]
  associate_public_ip_address = true
  tags = {
    Name = "tf-${var.env_prefix}-pup-ec2"
  }
}

resource "aws_instance" "tf-prv-ec2" {
  ami             = data.aws_ami.ubuntu22.id
  subnet_id       = aws_subnet.tf_private_subnet.id
  instance_type   = var.instance_type
  key_name        = aws_key_pair.ssh-key.key_name
  security_groups = [aws_default_security_group.tf-sg.id]
  tags = {
    Name = "tf-${var.env_prefix}-prv-ec2"
  }
}

resource "aws_key_pair" "ssh-key" {
  key_name = "ec2-key-pair"
  public_key = file(var.public_key_location) #locate ec2 public key, you can use ~/.ssh/id_rsa
}