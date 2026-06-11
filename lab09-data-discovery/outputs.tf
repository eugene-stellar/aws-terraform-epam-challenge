output "instance_name" {
  description = "Provides instance name."
  value       = aws_instance.instance.tags.Name
}

output "instance_id" {
  description = "Provides instance ID."
  value       = aws_instance.instance.id
}
