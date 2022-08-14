resource "aws_sns_topic" "cloud" {
  count                       = length(var.topic)
  name                        = lookup(var.topic[count.index], "name")
  delivery_policy             = lookup(var.topic[count.index], "delivery_policy", null)
  kms_master_key_id           = lookup(var.topic[count.index], "kms_master_key_id", null)
  fifo_topic                  = lookup(var.topic[count.index], "fifo_topic", null)
  content_based_deduplication = lookup(var.topic[count.index], "content_based_deduplication", null)
}

resource "aws_sns_topic_subscription" "cloud" {
  count     = length(var.subs) > 1 ? length(var.subs) : 0
  topic_arn = aws_sns_topic.cloud[lookup(var.subs[count.index], "topic_count")].arn
  endpoint  = lookup(var.subs[count.index], "endpoint")
  protocol  = lookup(var.subs[count.index], "protocol")
  subscription_role_arn = lookup(var.subs[count.index], "protocol") != "firehouse" ? null : lookup(var.subs[count.index], "subscription_role_arn")
}