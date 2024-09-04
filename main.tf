provider "aws" {
    region = "eu-west-3"
}

resource "aws_vpc" "tf_1st_vpc" {
  cidr_block = "10.10.0.0/16"
  tags = {
    Name = "tf-1st-vpc"
  }
}

resource "aws_subnet" "tf_public_subnet" {
  vpc_id     = aws_vpc.tf_1st_vpc.id
  cidr_block = "10.10.1.0/24"

  availability_zone = "eu-west-3a"
  map_public_ip_on_launch = true
  tags = {
    Name = "tf-public-subnet"
  }


}

resource "aws_subnet" "tf_private_subnet" {
  vpc_id     = aws_vpc.tf_1st_vpc.id
  cidr_block = "10.10.2.0/24"

  availability_zone = "eu-west-3a"
  
  tags = {
    Name = "tf-private-subnet"
  }
}

resource "aws_route_table" "tf_1st_puplic_routetable" {
  vpc_id = aws_vpc.tf_1st_vpc.id
  tags = {
    Name = "tf-1st-puplic-routetable"
  }
}

resource "aws_route_table" "tf_1st_private_routetable" {
  vpc_id = aws_vpc.tf_1st_vpc.id
  tags = {
    Name = "tf-1st-private-routetable"
  }
}

resource "aws_route_table_association" "rta-pub" {
  route_table_id = aws_route_table.tf_1st_puplic_routetable.id
  subnet_id      = aws_subnet.tf_public_subnet.id   
}
resource "aws_route_table_association" "rta-private" {
  route_table_id = aws_route_table.tf_1st_private_routetable.id
  subnet_id      = aws_subnet.tf_private_subnet.id
}

resource "aws_internet_gateway" "tf_1st_igw" {
  vpc_id = aws_vpc.tf_1st_vpc.id
  tags = {
    Name = "tf-1st-igw"
  }
}

resource "aws_route" "route-pup-rt" {
  route_table_id = aws_route_table.tf_1st_puplic_routetable.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id     = aws_internet_gateway.tf_1st_igw.id
}

resource "aws_security_group" "tf-sg" {
    vpc_id = aws_vpc.tf_1st_vpc.id
    name = "tf-SG"
    ingress {
        from_port = 22
        protocol = "tcp"
        to_port = 22
        cidr_blocks = ["0.0.0.0/0"]
    }    
    egress {
        from_port = 0
        protocol = "-1"
        to_port = 0
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "tf-pub-ec2" {
  ami = "ami-04a92520784b93e73"
  subnet_id = aws_subnet.tf_public_subnet.id
  instance_type = "t2.micro"
  key_name = "ahmed-tf-test"
  security_groups = [aws_security_group.tf-sg.id]
  tags = {
    Name = "terraform-pup-ec2"
  }
}

resource "aws_instance" "tf-prv-ec2" {
  ami = "ami-04a92520784b93e73"
  subnet_id = aws_subnet.tf_private_subnet.id
  instance_type = "t2.micro"
  key_name = "ahmed-tf-test"
  security_groups = [aws_security_group.tf-sg.id]
  tags = {
    Name = "terraform-prv-ec2"
  }
}