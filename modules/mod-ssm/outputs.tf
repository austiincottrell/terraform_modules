output "ssm_parameter_arn" {
  value       = aws_ssm_parameter.cloud.*.arn
  description = "arn of the parameter created"
}

output "ssm_parameter_name" {
  value       = aws_ssm_parameter.cloud.*.name
  description = "name of the parameter created"
}

output "ssm_parameter_value" {
  value       = aws_ssm_parameter.cloud.*.value
  description = "value of the parameter created"
  sensitive   = true
}
