output "target_group_id" {
  description = "Provides TG ID."
  value       = aws_lb_target_group.tg.id
}

output "lb_id" {
  description = "Provides LB ID."
  value       = aws_alb.alb.id
}