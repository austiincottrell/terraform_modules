output "athena_db_id" {
  value       = aws_athena_database.cloud.0.id
  description = "database that holds all queries"
}

output "athena_workergroup_id" {
  value       = aws_athena_workgroup.cloud.0.id
  description = "workergroup that runs all queries"
}

output "athena_workergroup_arn" {
  value       = aws_athena_workgroup.cloud.0.arn
  description = "workergroup that runs all queries"
}

output "sql_queries_id" {
  value       = aws_athena_named_query.cloud.*.id
  description = "queries"
}