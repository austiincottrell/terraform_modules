output "invoke_url" {
  value       = aws_api_gateway_stage.api.*.invoke_url
  description = "description"
}

output "arn" {
  value       = aws_api_gateway_stage.api.*.arn
  description = "description"
}

output "api_key" {
  value       = aws_api_gateway_api_key.cloud.*.value
  sensitive   = true
  description = "The api key for authorization to the api gateway"
}

output "api_key_id" {
  value       = aws_api_gateway_api_key.cloud.*.id
  sensitive   = true
  description = "The api key id"
}
