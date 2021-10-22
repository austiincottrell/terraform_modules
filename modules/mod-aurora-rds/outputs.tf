output "rds_arn" {
  value       = aws_rds_cluster.serverless.*.arn
  description = "rds cluster arn"
}

output "rds_endpoint" {
  value       = aws_rds_cluster.serverless.*.endpoint
  description = "rds cluster address"
}

output "rds_cluster_identifier" {
  value       = aws_rds_cluster.serverless.*.cluster_identifier
  description = "rds cluster name"
}