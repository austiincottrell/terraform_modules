resource "aws_cloudtrail" "cloud" {
  count                         = length(var.trail)
  name                          = lookup(var.trail[count.index], "name")
  s3_bucket_name                = lookup(var.trail[count.index], "s3_bucket")
  kms_key_id                    = lookup(var.trail[count.index], "kms", null)
  s3_key_prefix                 = lookup(var.trail[count.index], "prefix", null)
  sns_topic_name                = lookup(var.trail[count.index], "sns", null)
  include_global_service_events = false
}

