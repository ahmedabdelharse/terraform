resource "aws_subnet" "tf_public_subnet" {
  vpc_id     = aws_vpc.tf_lab1_vpc.id
  cidr_block = "10.10.1.0/24"
  availability_zone       = "eu-west-3a"
  tags = {
    Name = "tf-public-subnet"
  }
}

resource "aws_subnet" "tf_private_subnet" {
  vpc_id     = aws_vpc.tf_lab1_vpc.id
  cidr_block = "10.10.2.0/24"
  availability_zone = "eu-west-3a"
  tags = {
    Name = "tf-private-subnet"
  }
}