variable "launch_template_name" {
  description = "Provides launch template name."
  type        = string
}

variable "ssh_sg_name" {
  description = "Provides ssh SG name."
  type        = string
}

variable "http_sg_name" {
  description = "Provides http SG name."
  type        = string
}

variable "key_pair_name" {
  description = "Provides key pair name."
  type        = string
}

variable "iam_instance_profile_name" {
  description = "Provides IAM instance profile name."
  type        = string
}

variable "asg_name" {
  description = "Provides ASG name."
  type        = string
}

variable "project_name" {
  description = "Provides project name."
  type        = string
}

variable "alb_name" {
  description = "Provides ALB name."
  type        = string
}

variable "alb_sg_name" {
  description = "Provides ALB SG name."
  type        = string
}

variable "vpc_name" {
  description = "Provides VPC name."
  type        = string
}