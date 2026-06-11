resource "aws_security_group" "ssh_security_group" {
  name        = var.ssh_security_group_name
  description = "Security group for SSH and ICMP access"
  vpc_id      = var.vpc_id

  tags = {
    Project = var.project_id
  }
}

resource "aws_security_group_rule" "ssh_ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.allowed_ip_range
  security_group_id = aws_security_group.ssh_security_group.id
}

resource "aws_security_group_rule" "ssh_icmp_ingress" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = var.allowed_ip_range
  security_group_id = aws_security_group.ssh_security_group.id
}

resource "aws_security_group_rule" "ssh_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ssh_security_group.id
}

resource "aws_security_group" "public_http_security_group" {
  name        = var.public_http_security_group_name
  vpc_id      = var.vpc_id
  description = "Security group for Public HTTP access"

  tags = {
    Project = var.project_id
  }
}

resource "aws_security_group_rule" "public_http_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = var.allowed_ip_range
  security_group_id = aws_security_group.public_http_security_group.id
}

resource "aws_security_group_rule" "public_icmp_ingress" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = var.allowed_ip_range
  security_group_id = aws_security_group.public_http_security_group.id
}

resource "aws_security_group_rule" "public_http_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public_http_security_group.id
}

resource "aws_security_group" "private_http_security_group" {
  name        = var.private_http_security_group_name
  vpc_id      = var.vpc_id
  description = "Security group for Private HTTP access from Public SG"

  tags = {
    Project = var.project_id
  }
}

resource "aws_security_group_rule" "private_http_ingress" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.public_http_security_group.id
  security_group_id        = aws_security_group.private_http_security_group.id
}

resource "aws_security_group_rule" "private_icmp_ingress" {
  type                     = "ingress"
  from_port                = -1
  to_port                  = -1
  protocol                 = "icmp"
  source_security_group_id = aws_security_group.public_http_security_group.id
  security_group_id        = aws_security_group.private_http_security_group.id
}

resource "aws_network_interface_sg_attachment" "public_eni_public_http_sg_attach" {
  network_interface_id = data.aws_instance.public.network_interface_id
  security_group_id    = aws_security_group.public_http_security_group.id
}

resource "aws_network_interface_sg_attachment" "public_eni_ssh_sg_attach" {
  network_interface_id = data.aws_instance.public.network_interface_id
  security_group_id    = aws_security_group.ssh_security_group.id
}

resource "aws_network_interface_sg_attachment" "private_eni_ssh_sg_attach" {
  network_interface_id = data.aws_instance.private.network_interface_id
  security_group_id    = aws_security_group.ssh_security_group.id
}

resource "aws_network_interface_sg_attachment" "public_eni_private_http_sg_attach" {
  network_interface_id = data.aws_instance.private.network_interface_id
  security_group_id    = aws_security_group.private_http_security_group.id
}

data "aws_instance" "public" {
  instance_id = var.public_ec2_instance_id
}

data "aws_instance" "private" {
  instance_id = var.private_ec2_instance_id
}