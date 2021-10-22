output "dynamodb_id" {
  value       = aws_dynamodb_table.db.*.id
  description = "id of the DynamoDB Table"
}

output "dynamodb_arn" {
  value       = aws_dynamodb_table.db.*.arn
  description = "arn of the DynamoDB Table"
}
