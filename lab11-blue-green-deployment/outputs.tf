output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer to access the website."
  value       = aws_alb.alb.dns_name
}