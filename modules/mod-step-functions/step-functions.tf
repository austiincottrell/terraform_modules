resource "aws_sfn_state_machine" "step" {
  count      = length(var.step)
  name       = lookup(var.step[count.index], "name")
  role_arn   = lookup(var.step[count.index], "iam_role")
  definition = lookup(var.step[count.index], "definition")
}