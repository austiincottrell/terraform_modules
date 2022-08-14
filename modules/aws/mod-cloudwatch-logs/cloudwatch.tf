resource "aws_cloudwatch_log_group" "cloud" {
  count      = length(var.log_group) > 0 ? length(var.log_group) : 0
  name       = "${lookup(var.log_group[count.index], "prefix")}${lookup(var.log_group[count.index], "name")}"
  kms_key_id = var.cloudwatch_kms_key 
}