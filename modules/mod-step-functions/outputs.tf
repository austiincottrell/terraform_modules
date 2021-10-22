output "machine_id" {
  value       = aws_sfn_state_machine.step.*.id
  description = "id of our step function machine"
}

output "machine_arn" {
  value       = aws_sfn_state_machine.step.*.arn
  description = "arn of our step function machine"
}

output "machine_status" {
  value       = aws_sfn_state_machine.step.*.status
  description = "status of our step function machine"
}
