output "ec2_inst_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.ec2_inst.id
}

output "ec2_public_ip" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.ec2_inst.public_ip
}