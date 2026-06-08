output "public_instance_public_ip" {
  description = "The public IP address of the public EC2 instance to test the Nginx welcome page."
  value       = data.aws_instance.public.public_ip
}

output "ssh_security_group_id" {
  description = "The ID of the created SSH Security Group."
  value       = aws_security_group.ssh_security_group.id
}

output "public_http_security_group_id" {
  description = "The ID of the created Public HTTP Security Group."
  value       = aws_security_group.public_http_security_group.id
}

output "private_http_security_group_id" {
  description = "The ID of the created Private HTTP Security Group."
  value       = aws_security_group.private_http_security_group.id
}