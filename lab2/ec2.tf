data "aws_vpc" "existing_vpc" {
  tags = {
    Name = "cmtr-gy0ttqu8-vpc"
  }
}

data "aws_subnets" "public" {

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing_vpc.id]
  }
  filter {
    name   = "map-public-ip-on-launch"
    values = ["true"]
  }
}

data "aws_security_group" "existing_sg" {
  tags = {
    Name = "cmtr-gy0ttqu8-sg"
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64*"]
  }
}

resource "aws_instance" "ec2_inst" {

  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"

  key_name               = var.ssh_key_pair_name
  vpc_security_group_ids = [data.aws_security_group.existing_sg.id]
  subnet_id              = tolist(data.aws_subnets.public.ids)[0]

  depends_on = [aws_key_pair.key_pair]

  tags = {
    Name    = var.ec2_inst_name
    Project = "epam-tf-lab"
    ID      = "cmtr-gy0ttqu8"
  }
}