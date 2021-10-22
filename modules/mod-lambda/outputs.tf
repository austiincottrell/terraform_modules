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
