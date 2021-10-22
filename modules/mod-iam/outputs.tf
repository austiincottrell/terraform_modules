output "iam_role_id" {
  value       = aws_iam_role.role.*.id
  description = "role id"
}

output "iam_role_arn" {
  value       = aws_iam_role.role.*.arn
  description = "role arn"
}

output "iam_policy_id" {
  value       = aws_iam_policy.policy.*.id
  description = "policy id"
}

output "iam_policy_arn" {
  value       = aws_iam_policy.policy.*.arn
  description = "policy arn"
}

### Role ###

# output "role_arn" {
#   value       = aws_iam_role.just_role.*.arn
#   description = "role arn"
# }

# output "role_id" {
#   value       = aws_iam_role.just_role.*.id
#   description = "role id"
# }

### Policy ###

# output "policy_arn" {
#   value       = aws_iam_policy.just_policy.*.arn
#   description = "policy arn"
# }

# output "policy_id" {
#   value       = aws_iam_policy.just_policy.*.id
#   description = "policy id"
# }
