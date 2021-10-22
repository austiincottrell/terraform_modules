locals {
  dvo    = "${flatten(aws_acm_certificate.cert.domain_validation_options)}"
  domain = var.domains
}

data "aws_route53_zone" "zone" {
  name         = var.domains
  private_zone = false
}

resource "aws_acm_certificate" "cert" {
  domain_name               = var.domains
  subject_alternative_names = var.san
  validation_method         = "DNS"
  
  tags = var.my_tags
}

resource "aws_route53_record" "cert_validation" {
  allow_overwrite = true
  count   = length(var.san) + 1
  zone_id = data.aws_route53_zone.zone.zone_id
  
  ttl     = 60

  name    = lookup(local.dvo[count.index], "resource_record_name")
  type    = lookup(local.dvo[count.index], "resource_record_type")
  records = [lookup(local.dvo[count.index], "resource_record_value")]
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]

  depends_on = [aws_route53_record.cert_validation]
}