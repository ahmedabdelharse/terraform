resource "aws_vpc" "tf_lab1_vpc" {
  cidr_block = "10.10.0.0/16"
  tags = {
    Name = "tf-lab1-vpc"
  }
}

resource "aws_default_security_group" "tf-sg" {
  vpc_id = aws_vpc.tf_lab1_vpc.id
  tags = {
    Name = "tf-SG"
  }
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_default_route_table" "tf_lab1_routetable" {
  default_route_table_id = aws_vpc.tf_lab1_vpc.default_route_table_id
  tags = {
    Name = "tf-lab1-routetable"
  }
}

resource "aws_route" "route-pup-rt" {
  route_table_id         = aws_default_route_table.tf_lab1_routetable.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.tf_lab1_igw.id
}

resource "aws_internet_gateway" "tf_lab1_igw" {
  vpc_id = aws_vpc.tf_lab1_vpc.id
  tags = {
    Name = "tf-lab1-igw"
  }
}