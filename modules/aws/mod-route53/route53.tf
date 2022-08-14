data "aws_route53_zone" "zone" {
  name         = var.domain
  private_zone = false
}

resource "aws_route53_record" "record" {
  count           = length(var.record)
  zone_id         = data.aws_route53_zone.zone.zone_id
  name            = lookup(var.record[count.index], "domain")
  type            = lookup(var.record[count.index], "type")
  set_identifier  = "primary"
  allow_overwrite = true
  health_check_id = aws_route53_health_check.cloud[count.index].id

  # # Either ttl & record or alias
  # ttl     = lookup(var.record[count.index], "ttl", null)
  # records = [lookup(var.record[count.index], "record", null)]

  failover_routing_policy {
    type = "PRIMARY"
  }

  alias {
    name                   = lookup(var.record[count.index], "alias_name", null)
    zone_id                = lookup(var.record[count.index], "alias_zone", null)
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "failover" {
  count           = length(var.record)
  zone_id         = data.aws_route53_zone.zone.zone_id
  name            = lookup(var.record[count.index], "failover_domain")
  type            = lookup(var.record[count.index], "failover_type")
  set_identifier  = "failover"
  allow_overwrite = true

  # # Either ttl & record or alias
  # ttl     = lookup(var.record[count.index], "ttl", null)
  # records = [lookup(var.record[count.index], "record", null)]

  failover_routing_policy {
    type = "SECONDARY"
  }

  alias {
    name                   = lookup(var.record[count.index], "failover_alias_name", null)
    zone_id                = lookup(var.record[count.index], "failover_alias_zone", null)
    evaluate_target_health = true
  }
}