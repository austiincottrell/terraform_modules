output "invoke_url" {
  value       = aws_api_gateway_stage.api.*.invoke_url
  description = "description"
}

output "arn" {
  value       = aws_api_gateway_stage.api.*.arn
  description = "description"
}
