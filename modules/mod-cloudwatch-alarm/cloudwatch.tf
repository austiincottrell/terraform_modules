resource "aws_cloudwatch_metric_alarm" "cloud" {
  count                     = length(var.cloudalarm) > 0 ? length(var.cloudalarm) : 0
  # General
  alarm_name                = lookup(var.cloudalarm[count.index], "alarm_name")
  comparison_operator       = lookup(var.cloudalarm[count.index], "comparison") 
  evaluation_periods        = lookup(var.cloudalarm[count.index], "evaluation_periods")
  threshold                 = lookup(var.cloudalarm[count.index], "threshold")
  alarm_description         = lookup(var.cloudalarm[count.index], "description", null)
  # Alarm Actions
  actions_enabled           = length(lookup(var.cloudalarm[count.index], "sns_topic_arn", null)) > 0 ? "true" : "false"
  alarm_actions             = [lookup(var.cloudalarm[count.index], "sns_topic_arn", null)]
  insufficient_data_actions = []
  # ID
  metric_query {
    id          = lookup(var.cloudalarm[count.index], "id")
    return_data = lookup(var.cloudalarm[count.index], "return_data")
  # Alarm Details
    metric {
      metric_name = lookup(var.cloudalarm[count.index], "metric_name")
      namespace   = lookup(var.cloudalarm[count.index], "namespace")
      period      = lookup(var.cloudalarm[count.index], "period")
      stat        = lookup(var.cloudalarm[count.index], "statistic")
      unit        = lookup(var.cloudalarm[count.index], "unit", "Count")
      dimensions  = element(var.dimensions, count.index)
    }
  }
}
