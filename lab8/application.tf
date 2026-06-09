resource "aws_launch_template" "name" {
  name          = var.launch_template_name
  instance_type = "t3.micro"

  image_id = data.aws_ami.ami.id

  network_interfaces {
    delete_on_termination = true
    security_groups       = [data.aws_security_group.http_sg.id, data.aws_security_group.ssh_sg.id]
  }

  key_name = var.key_pair_name

  iam_instance_profile {
    name = var.iam_instance_profile_name
  }

  user_data = base64encode(<<-EOF
  #!/bin/bash
  
  dnf update -y

  dnf install -y httpd jq

  systemctl enable httpd --now

  TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

  INSTANCE_ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/instance-id)
  PRIVATE_IP=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/local-ipv4)

  echo "This message was generated on instance $INSTANCE_ID with the following IP: $PRIVATE_IP" > /var/www/html/index.html

  EOF
  )

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }

  tags = {
    Terraform = "true"
    Project   = var.project_name
  }
}

data "aws_security_group" "ssh_sg" {
  name = var.ssh_sg_name
}

data "aws_security_group" "http_sg" {
  name = var.http_sg_name
}

data "aws_ami" "ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

data "aws_subnet" "public_a" {
  cidr_block = "10.0.1.0/24"
}

data "aws_subnet" "public_b" {
  cidr_block = "10.0.3.0/24"
}

resource "aws_autoscaling_group" "asg" {

  name = var.asg_name

  desired_capacity = 2
  min_size         = 1
  max_size         = 2

  vpc_zone_identifier = [data.aws_subnet.public_a.id, data.aws_subnet.public_b.id]

  launch_template {
    id      = aws_launch_template.name.id
    version = "$Latest"
  }

  lifecycle {
    ignore_changes = [
      load_balancers,
      target_group_arns
    ]
  }

  tag {
    key                 = "Project"
    value               = var.project_name
    propagate_at_launch = true
  }
}

resource "aws_alb" "alb" {

  name               = var.alb_name
  load_balancer_type = "application"

  security_groups = [data.aws_security_group.alb_sg.id]
  subnets         = [data.aws_subnet.public_a.id, data.aws_subnet.public_b.id]

  tags = {
    Terraform = "true"
    Project   = var.project_name
  }
}

data "aws_security_group" "alb_sg" {
  name = var.alb_sg_name
}

resource "aws_autoscaling_attachment" "asg_alb_attach" {
  autoscaling_group_name = aws_autoscaling_group.asg.id
  lb_target_group_arn    = aws_lb_target_group.tg.arn
}

resource "aws_lb_listener" "lb_listener_http" {
  load_balancer_arn = aws_alb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_lb_target_group" "tg" {
  name        = "${var.project_name}-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = data.aws_vpc.vpc.id
}

data "aws_vpc" "vpc" {
  tags = {
    Name = var.vpc_name
  }
}