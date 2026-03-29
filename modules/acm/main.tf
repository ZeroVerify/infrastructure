locals {
  regions = concat([var.primary_region], var.replica_regions)
}

resource "aws_acm_certificate" "api" {
  for_each = toset(local.regions)

  region            = each.value
  domain_name       = "*.api.${var.domain_name}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}

# All regional certs for the same domain share the same validation CNAME.
# Use the primary region cert as the source of validation options.
resource "aws_route53_record" "api_cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.api[var.primary_region].domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = var.api_zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "api" {
  for_each = toset(local.regions)

  region          = each.value
  certificate_arn = aws_acm_certificate.api[each.value].arn
  validation_record_fqdns = [for record in aws_route53_record.api_cert_validation : record.fqdn]
}
