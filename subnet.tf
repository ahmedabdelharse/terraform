resource "aws_subnet" "tf_public_subnet" {
  vpc_id            = aws_vpc.tf_lab1_vpc.id
  cidr_block        = var.cidr_blocks[1].cidr_block
  availability_zone = var.a_z
  tags = {
    Name = var.cidr_blocks[1].name

  }
}

resource "aws_subnet" "tf_private_subnet" {
  vpc_id            = aws_vpc.tf_lab1_vpc.id
  cidr_block        = var.cidr_blocks[2].cidr_block
  availability_zone = var.a_z
  tags = {
    Name = var.cidr_blocks[2].name
  }
}