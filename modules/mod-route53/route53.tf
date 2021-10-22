data "aws_route53_zone" "zone" {
  name         = var.domain
  private_zone = false
}

resource "aws_route53_record" "record" {
  count   = length(var.record)
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = lookup(var.record[count.index], "domain")
  type    = lookup(var.record[count.index], "type")

  # # Either ttl & record or alias
  # ttl     = lookup(var.record[count.index], "ttl", null)
  # records = [lookup(var.record[count.index], "record", null)]
  
  alias {
    name                   = lookup(var.record[count.index], "alias_name", null)
    zone_id                = lookup(var.record[count.index], "alias_zone", null)
    evaluate_target_health = true
  }

  allow_overwrite = true
}