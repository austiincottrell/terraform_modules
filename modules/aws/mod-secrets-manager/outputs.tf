output "secret_arn" {
  value       = aws_secretsmanager_secret.my_secret.*.arn
}

output "secret" {
  value       = aws_secretsmanager_secret_version.secret.*.secret_string
  sensitive   = true
}

output "secret_rds_arn" {
  value       = aws_secretsmanager_secret.rds.*.arn
}

output "secret_rds_json" {
  value       = aws_secretsmanager_secret_version.rds.*.secret_string
  sensitive   = true
  # this will print the json code of the rds password
}

output "secret_rds" {
  value       = random_password.rds-password.*.result
  sensitive   = true
  # this will print the rds password
}