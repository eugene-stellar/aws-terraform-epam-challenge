resource "aws_instance" "instance" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.ami.id
  subnet_id              = data.aws_subnet.subnet.id
  vpc_security_group_ids = [data.aws_security_group.sg.id]

  tags = {
    Name    = var.instance_name
    Project = var.project_id
  }
}