resource "aws_ssm_parameter" "cloud" {
  count = length(var.ssm_parameter)
  name  = lookup(var.ssm_parameter[count.index], "name")
  type  = lookup(var.ssm_parameter[count.index], "type")
  tier  = lookup(var.ssm_parameter[count.index], "tier")
  value = lookup(var.ssm_parameter[count.index], "value")
  description = lookup(var.ssm_parameter[count.index], "description")
}