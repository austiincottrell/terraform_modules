# resource "aws_cloudwatch_metric_alarm" "cloud" {
#   count                     = length(var.cloudalarm) > 0 ? length(var.cloudalarm) : 0

#   alarm_name                = lookup(var.cloudalarm[count.index], "alarm_name", null)
#   comparison_operator       = lookup(var.cloudalarm[count.index], "comparison", null) 
#   evaluation_periods        = lookup(var.cloudalarm[count.index], "evaluation_periods", null) 
#   metric_name               = "CPUUtilization"
#   namespace                 = "AWS/EC2"
#   period                    = "120"
#   statistic                 = "Average"
#   threshold                 = "80"
#   alarm_description         = "This metric monitors ec2 cpu utilization"
#   insufficient_data_actions = []
# }

resource "aws_cloudwatch_log_group" "cloud" {
  count      = length(var.log_group) > 0 ? length(var.log_group) : 0
  name       = lookup(var.log_group[count.index], "name")
  kms_key_id = var.cloudwatch_kms_key 
}