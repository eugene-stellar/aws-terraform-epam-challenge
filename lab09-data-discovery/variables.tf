variable "vpc_name" {
  description = "Provides VPC name."
  type        = string
}

variable "public_subnet_name" {
  description = "Provides public subnet name."
  type        = string
}

variable "security_group_name" {
  description = "Provides SG name."
  type        = string
}

variable "project_id" {
  description = "Provides project ID."
  type        = string
}

variable "aws_region" {
  description = "Provides AWS region."
  type        = string
}

variable "instance_name" {
  description = "Provides instance name region."
  type        = string
}