output "vpc_id" {
  description = "Provides VPC ID."
  value       = aws_vpc.vpc.id
}

output "vpc_cidr" {
  description = "Provides VPC cidr."
  value       = aws_vpc.vpc.cidr_block
}

output "public_subnet_ids" {
  description = "Provides IDs of all public subnets."
  value = [
    aws_subnet.subnet_a.id,
    aws_subnet.subnet_b.id,
    aws_subnet.subnet_c.id
  ]
}

output "public_subnet_cidr_block" {
  description = "Provides CIDR blocks of all public subnets."
  value = [
    aws_subnet.subnet_a.cidr_block,
    aws_subnet.subnet_b.cidr_block,
    aws_subnet.subnet_c.cidr_block
  ]
}

output "public_subnet_availability_zone" {
  description = "The Availability Zones of all public subnets."
  value = [
    aws_subnet.subnet_a.availability_zone,
    aws_subnet.subnet_b.availability_zone,
    aws_subnet.subnet_c.availability_zone
  ]
}

output "internet_gateway_id" {
  description = "Provides IGW ID."
  value       = aws_internet_gateway.igw.id
}

output "routing_table_id" {
  description = "Provides RT ID."
  value       = aws_route_table.rt.id
}