output "machine_arn" {
  value       = aws_sfn_state_machine.step.*.arn
  description = "arn of our step function machine"
}

output "event_machine_arn" {
  value       = aws_sfn_state_machine.event.*.arn
  description = "arn of our step function machine"
}
