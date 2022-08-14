resource "aws_sfn_state_machine" "step" {
  count      = length(var.step)
  name       = lookup(var.step[count.index], "name")
  role_arn   = lookup(var.step[count.index], "iam_role")
  definition = lookup(var.step[count.index], "definition")

  dynamic "logging_configuration" {
    for_each = var.logging[count.index]
    content {
      include_execution_data = logging_configuration.value["include_execution_data"]
      level = logging_configuration.value["level"]
      log_destination = logging_configuration.value["log_destination"]
    }
  }
}

##################################
### Event Driven Step Function ###
##################################

resource "aws_sfn_state_machine" "event" {
  count      = length(var.event_step) > 1 ? length(var.event_step) : 0
  name       = lookup(var.event_step[count.index], "name")
  role_arn   = lookup(var.event_step[count.index], "iam_role")
  definition = lookup(var.event_step[count.index], "definition")
}

resource "aws_cloudwatch_event_rule" "event" {
  count               = length(var.event_step) > 1 ? length(var.event_step) : 0
  name                = lookup(var.event_step[count.index], "name")
  event_pattern       = lookup(var.event_step[count.index], "event_pattern", null)
  schedule_expression = lookup(var.event_step[count.index], "schedule_expression")
}

resource "aws_cloudwatch_event_target" "event" {
  count    = length(var.event_step) > 1 ? length(var.event_step) : 0
  arn      = aws_sfn_state_machine.event[count.index].arn
  rule     = aws_cloudwatch_event_rule.event[count.index].name
  role_arn = lookup(var.event_step[count.index], "iam_role")
}
