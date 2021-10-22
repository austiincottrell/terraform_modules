output "id" {
  value       = aws_cloudfront_distribution.cloud.*.id
  description = "description"
}

output "arn" {
  value       = aws_cloudfront_distribution.cloud.*.arn
  description = "description"
}

output "status" {
  value       = aws_cloudfront_distribution.cloud.*.status
  description = "description"
}

output "enabled" {
  value       = aws_cloudfront_distribution.cloud.*.enabled
  description = "description"
}

output "domain_name" {
  value       = aws_cloudfront_distribution.cloud.*.domain_name
  description = "description"
}

output "hosted_zone_id" {
  value       = aws_cloudfront_distribution.cloud.*.hosted_zone_id
  description = "description"
}
