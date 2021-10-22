output "id" {
  value       = aws_acm_certificate.cert.*.id
  description = "id of cert"
}

output "arn" {
  value       = aws_acm_certificate.cert.*.arn
  description = "arn of cert"
}

output "domain" {
  value       = aws_acm_certificate.cert.*.domain_name
  description = "domain name of the cert"
}

output "fqdn" {
  value = aws_acm_certificate.cert.*.domain_validation_options
}