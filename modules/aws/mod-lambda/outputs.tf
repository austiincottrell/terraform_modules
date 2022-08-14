output "arn" {
  value       = aws_lambda_function.lambda.*.arn
  description = "description"
}

output "invoke_arn" {
  value       = aws_lambda_function.lambda.*.invoke_arn
  description = "description"
}

output "version" {
  value       = aws_lambda_function.lambda.*.version
  description = "description"
}

output "event_arn" {
  value       = aws_lambda_function.event.*.arn
  description = "description"
}

output "event_invoke_arn" {
  value       = aws_lambda_function.event.*.invoke_arn
  description = "description"
}

output "event_version" {
  value       = aws_lambda_function.event.*.version
  description = "description"
}
