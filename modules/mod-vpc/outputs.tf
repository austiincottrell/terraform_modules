output "vpc_id" {
  value       = aws_vpc.vpc.id
  description = "id of the VPC"
}

output "subnet_id" {
  value       = aws_subnet.subnet.*.id
}

output "subnet_az" {
  value       = local.total_az
  description = "description"
}

