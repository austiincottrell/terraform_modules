resource "aws_flow_log" "cloud" {
  count           = length(var.flow_log) > 0 ? 1 : 0
  iam_role_arn    = lookup(var.flow_log[count.index], "flow_log_iam_arn")
  log_destination = aws_cloudwatch_log_group.cloud[0].arn
  traffic_type    = "ALL"
  vpc_id          = lookup(var.flow_log[count.index], "vpc_id")
}

