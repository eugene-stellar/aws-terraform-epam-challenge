resource "aws_alb" "alb" {
  name = var.alb_name

  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.http_alb_sg.id]
  subnets            = [data.aws_subnet.subnet1.id, data.aws_subnet.subnet2.id]

  tags = {
    Name = var.alb_name
  }
}

resource "aws_lb_listener" "lb_listener_http" {
  load_balancer_arn = aws_alb.alb.arn
  protocol          = "HTTP"
  port              = "80"

  default_action {
    type = "forward"

    forward {
      target_group {
        arn    = aws_lb_target_group.blue_tg.arn
        weight = var.blue_weight
      }
      target_group {
        arn    = aws_lb_target_group.green_tg.arn
        weight = var.green_weight
      }
    }
  }
}

resource "aws_lb_target_group" "blue_tg" {
  name = var.blue_tg_name

  protocol    = "HTTP"
  port        = 80
  target_type = "instance"

  vpc_id = data.aws_vpc.vpc.id

  tags = {
    Name = var.blue_tg_name
  }
}

resource "aws_lb_target_group" "green_tg" {
  name = var.green_tg_name

  protocol    = "HTTP"
  port        = 80
  target_type = "instance"

  vpc_id = data.aws_vpc.vpc.id

  tags = {
    Name = var.green_tg_name
  }
}

data "aws_security_group" "http_alb_sg" {
  filter {
    name   = "tag:Name"
    values = [var.http_sg_lb_name]
  }
}

data "aws_subnet" "subnet1" {
  filter {
    name   = "tag:Name"
    values = [var.subnet1_name]
  }
}

data "aws_subnet" "subnet2" {
  filter {
    name   = "tag:Name"
    values = [var.subnet2_name]
  }
}

data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

resource "aws_launch_template" "blue_launch_template" {
  name          = var.blue_lt_name
  instance_type = "t3.micro"

  image_id               = data.aws_ami.ami.id
  vpc_security_group_ids = [data.aws_security_group.ssh.id, data.aws_security_group.http_ec2.id]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    dnf install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Blue Environment</h1>" > /var/www/html/index.html
  EOF
  )

}

resource "aws_launch_template" "green_launch_template" {
  name          = var.green_lt_name
  instance_type = "t3.micro"

  image_id               = data.aws_ami.ami.id
  vpc_security_group_ids = [data.aws_security_group.ssh.id, data.aws_security_group.http_ec2.id]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    dnf install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Green Environment</h1>" > /var/www/html/index.html
  EOF
  )
}


data "aws_ami" "ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

data "aws_security_group" "ssh" {
  filter {
    name   = "tag:Name"
    values = [var.ssh_sg_name]
  }
}

data "aws_security_group" "http_ec2" {
  filter {
    name   = "tag:Name"
    values = [var.http_sg_name]
  }
}

resource "aws_autoscaling_group" "blue_asg" {
  name = var.blue_asg_name

  desired_capacity = 2
  min_size         = 1
  max_size         = 2

  vpc_zone_identifier = [data.aws_subnet.subnet1.id, data.aws_subnet.subnet2.id]

  launch_template {
    id      = aws_launch_template.blue_launch_template.id
    version = "$Latest"
  }

  lifecycle {
    ignore_changes = [
      load_balancers,
      target_group_arns
    ]
  }
  tag {
    key                 = "Name"
    value               = var.blue_asg_name
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "green_asg" {
  name = var.green_asg_name

  desired_capacity = 2
  min_size         = 1
  max_size         = 2

  vpc_zone_identifier = [data.aws_subnet.subnet1.id, data.aws_subnet.subnet2.id]

  launch_template {
    id      = aws_launch_template.green_launch_template.id
    version = "$Latest"
  }

  lifecycle {
    ignore_changes = [
      load_balancers,
      target_group_arns
    ]
  }
  tag {
    key                 = "Name"
    value               = var.green_asg_name
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "blue_asg_alb_attach" {
  autoscaling_group_name = aws_autoscaling_group.blue_asg.id
  lb_target_group_arn    = aws_lb_target_group.blue_tg.arn
}

resource "aws_autoscaling_attachment" "green_asg_alb_attach" {
  autoscaling_group_name = aws_autoscaling_group.green_asg.id
  lb_target_group_arn    = aws_lb_target_group.green_tg.arn
}