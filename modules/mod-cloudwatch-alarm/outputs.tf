output "alarm_arn" {
  value       = aws_cloudwatch_metric_alarm.cloud.*.arn
  description = "arn of the alarm"
}
