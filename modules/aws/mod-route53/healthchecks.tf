resource "aws_route53_health_check" "cloud" {
  count             = length(var.record)
  fqdn              = lookup(var.record[count.index], "hc_domainName")
  port              = lookup(var.record[count.index], "hc_port")
  type              = lookup(var.record[count.index], "hc_type")
  resource_path     = lookup(var.record[count.index], "hc_path")
  failure_threshold = "5"
  request_interval  = "30"

  tags = {
    Name = lookup(var.record[count.index], "hc_name")
  }
}