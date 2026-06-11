variable "alb_name" {
  description = "Provides ALB name."
  type        = string
}

variable "blue_tg_name" {
  description = "Provides Blue TG name."
  type        = string
}

variable "green_tg_name" {
  description = "Provides Green TG name."
  type        = string
}

variable "blue_asg_name" {
  description = "Provides Blue ASG name."
  type        = string
}

variable "green_asg_name" {
  description = "Provides Green ASG name."
  type        = string
}

variable "blue_lt_name" {
  description = "Provides Blue launch template name."
  type        = string
}

variable "green_lt_name" {
  description = "Provides Green launch template name."
  type        = string
}

variable "ssh_sg_name" {
  description = "Provides SSH SG name."
  type        = string
}

variable "http_sg_name" {
  description = "Provides http SG name."
  type        = string
}

variable "http_sg_lb_name" {
  description = "Allows HTTP access to the load balancer."
  type        = string
}

variable "vpc_name" {
  description = "Provides VPC name."
  type        = string
}

variable "subnet1_name" {
  description = "Provides subnet 1 name."
  type        = string
}

variable "subnet2_name" {
  description = "Provides subnet 2 name."
  type        = string
}

variable "blue_weight" {
  description = "Provides blue weight number."
  type        = number
}

variable "green_weight" {
  description = "Provides green weight number."
  type        = number
}