output "name" {
  value       = aws_route53_record.record.*.name
  description = "description"
}
