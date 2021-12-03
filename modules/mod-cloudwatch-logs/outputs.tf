output "log_group_arn" {
  value       = aws_cloudwatch_log_group.cloud.*.arn
  description = "arn of the log group"
}
