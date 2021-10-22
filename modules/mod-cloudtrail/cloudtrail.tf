resource "aws_cloudtrail" "cloud" {
  count                         = length(var.trail)
  name                          = lookup(var.trail[count.index], "name")
  s3_bucket_name                = lookup(var.trail[count.index], "s3_bucket")
  s3_key_prefix                 = lookup(var.trail[count.index], "prefix", null)
  include_global_service_events = false
}

