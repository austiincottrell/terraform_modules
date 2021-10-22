output "id" {
  value       = aws_s3_bucket.s3.*.id
  description = "id of the s3 bucket"
}

output "arn" {
  value       = aws_s3_bucket.s3.*.arn
  description = "arn of the s3 bucket"
}


output "website_id" {
  value       = aws_s3_bucket.website_s3.*.id
  description = "id of the s3 bucket"
}

output "website_arn" {
  value       = aws_s3_bucket.website_s3.*.arn
  description = "arn of the s3 bucket"
}

output "website_regional_domain_name" {
  value       = aws_s3_bucket.website_s3.*.bucket_regional_domain_name
}

output "website_domain" {
  value       = aws_s3_bucket.website_s3.*.website_domain
}

output "website_endpoint" {
  value       = aws_s3_bucket.website_s3.*.website_endpoint
}

output "logging_id" {
  value       = aws_s3_bucket.logging_s3.*.id
  description = "id of the s3 bucket"
}

output "logging_arn" {
  value       = aws_s3_bucket.logging_s3.*.arn
  description = "arn of the s3 bucket"
}

output "logging_regional_domain_name" {
  value       = aws_s3_bucket.logging_s3.*.bucket_regional_domain_name
}