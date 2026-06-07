variable "ssh_key" {
  description = "Provides custom public SSH key."
  type        = string
}

variable "ssh_key_pair_name" {
  description = "provides ssh key pair name."
  type        = string
}

variable "ec2_inst_name" {
  description = "provides ec2 instance name."
  type        = string
}
