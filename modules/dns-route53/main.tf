resource "aws_route53_record" "api_latency" {
  for_each = var.api_gateway_endpoints

  zone_id        = var.api_zone_id
  name           = "gw.api.${var.domain_name}"
  type           = "CNAME"
  ttl            = 60
  records        = [trimprefix(trimsuffix(each.value, "/"), "https://")]
  set_identifier = each.key

  latency_routing_policy {
    region = each.key
  }
}
