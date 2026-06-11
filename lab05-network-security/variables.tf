variable "allowed_ip_range" {
  description = "Provides list of IP ranges allowed to access the infrastructure."
  type        = list(string)
}

variable "vpc_id" {
  description = "Provides VPC ID."
  type        = string
}

variable "public_subnet_id" {
  description = "Provides public subnet ID."
  type        = string
}

variable "private_subnet_id" {
  description = "Provides private subnet ID."
  type        = string
}

variable "public_ec2_instance_id" {
  description = "Provides public ec2 instance ID."
  type        = string
}

variable "private_ec2_instance_id" {
  description = "Provides private ec2 instance ID."
  type        = string
}

variable "project_id" {
  description = "Provides the Project ID for tagging."
  type        = string
}

variable "ssh_security_group_name" {
  description = "Provides the name for the SSH Security Group."
  type        = string
}

variable "public_http_security_group_name" {
  description = "Provides the name for the Public HTTP Security Group."
  type        = string
}

variable "private_http_security_group_name" {
  description = "Provides the name for the Private HTTP Security Group."
  type        = string
}