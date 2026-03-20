data "cloudflare_zone" "main" {
  zone_id = var.cloudflare_zone_id
}

resource "cloudflare_dns_record" "www" {
  zone_id = data.cloudflare_zone.main.id
  name    = "www"
  content = "zeroverify.github.io"
  type    = "CNAME"
  ttl     = 300
  proxied = false
}

resource "cloudflare_dns_record" "github_pages_challenge" {
  zone_id = data.cloudflare_zone.main.id
  name    = "_github-pages-challenge-zeroverify"
  content = "64d2eff6d779b349eb7527b2a1b325"
  type    = "TXT"
  ttl     = 300
}

resource "aws_route53_zone" "api" {
  name = "api.${var.domain_name}"

  tags = var.tags
}

resource "cloudflare_dns_record" "api_ns" {
  count = 4

  zone_id = data.cloudflare_zone.main.id
  name    = "api"
  content = aws_route53_zone.api.name_servers[count.index]
  type    = "NS"
  ttl     = 300
}

resource "aws_route53_record" "api_latency" {
  for_each = var.api_gateway_endpoints

  zone_id        = aws_route53_zone.api.zone_id
  name           = "gw.api.${var.domain_name}"
  type           = "CNAME"
  ttl            = 60
  records        = [trimprefix(trimsuffix(each.value, "/"), "https://")]
  set_identifier = each.key

  latency_routing_policy {
    region = each.key
  }
}

resource "cloudflare_dns_record" "artifacts" {
  zone_id = data.cloudflare_zone.main.id
  name    = "artifacts"
  content = var.artifacts_bucket_domain_name
  type    = "CNAME"
  ttl     = 300
  proxied = false
}
