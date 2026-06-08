resource "aws_vpc" "vpc" {
  cidr_block = "10.10.0.0/16"

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "subnet_a" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = "eu-west-1a"
  cidr_block        = "10.10.1.0/24"

  tags = {
    Name = var.subnet_a_name
  }
}

resource "aws_subnet" "subnet_b" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = "eu-west-1b"
  cidr_block        = "10.10.3.0/24"

  tags = {
    Name = var.subnet_b_name
  }
}

resource "aws_subnet" "subnet_c" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = "eu-west-1c"
  cidr_block        = "10.10.5.0/24"

  tags = {
    Name = var.subnet_c_name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.igw_name
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.rt_name
  }
}

resource "aws_route_table_association" "rt_subnet_a" {
  route_table_id = aws_route_table.rt.id
  subnet_id      = aws_subnet.subnet_a.id
}

resource "aws_route_table_association" "rt_subnet_b" {
  route_table_id = aws_route_table.rt.id
  subnet_id      = aws_subnet.subnet_b.id
}

resource "aws_route_table_association" "rt_subnet_c" {
  route_table_id = aws_route_table.rt.id
  subnet_id      = aws_subnet.subnet_c.id
}