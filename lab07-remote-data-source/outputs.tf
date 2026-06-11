output "ec2_id" {
  description = "Provides EC2 instand ID."
  value       = aws_instance.instance.id
}