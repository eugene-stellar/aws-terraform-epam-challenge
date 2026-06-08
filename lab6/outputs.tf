output "vpc_id" {
  description = "Provides VPC ID."
  value       = aws_vpc.vpc.id
}

output "vpc_cidr" {
  description = "Provides VPC cidr."
  value       = aws_vpc.vpc.cidr_block
}

output "subnet_a_id" {
  description = "Provides subnet A ID."
  value       = aws_subnet.subnet_a.id
}

output "subnet_b_id" {
  description = "Provides subnet B ID."
  value       = aws_subnet.subnet_b.id
}

output "subnet_c_id" {
  description = "Provides subnet C ID."
  value       = aws_subnet.subnet_c.id
}

output "subnet_a_cidr" {
  description = "Provides subnet A cidr."
  value       = aws_subnet.subnet_a.cidr_block
}

output "subnet_b_cidr" {
  description = "Provides subnet B cidr."
  value       = aws_subnet.subnet_b.cidr_block
}

output "subnet_c_cidr" {
  description = "Provides subnet C cidr."
  value       = aws_subnet.subnet_c.cidr_block
}

output "subnet_a_az" {
  description = "Provides subnet A AZ."
  value       = aws_subnet.subnet_a.availability_zone
}

output "subnet_b_az" {
  description = "Provides subnet B AZ."
  value       = aws_subnet.subnet_b.availability_zone
}

output "subnet_c_az" {
  description = "Provides subnet C AZ."
  value       = aws_subnet.subnet_c.availability_zone
}

output "igw_id" {
  description = "Provides IGW ID."
  value       = aws_internet_gateway.igw.id
}

output "rt_id" {
  description = "Provides RT ID."
  value       = aws_route_table.rt.id
}