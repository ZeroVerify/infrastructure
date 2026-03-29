data "cloudflare_zone" "main" {
  zone_id = var.cloudflare_zone_id
}

resource "cloudflare_dns_record" "apex" {
  zone_id = data.cloudflare_zone.main.id
  name    = "@"
  content = "www.${var.domain_name}"
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

resource "cloudflare_dns_record" "www" {
  zone_id = data.cloudflare_zone.main.id
  name    = "www"
  content = "zeroverify.github.io"
  type    = "CNAME"
  ttl     = 300
  proxied = false
}

resource "cloudflare_dns_record" "keycloak" {
  zone_id = data.cloudflare_zone.main.id
  name    = "keycloak"
  content = "cnzozeob.up.railway.app"
  type    = "CNAME"
  ttl     = 300
  proxied = false
}

resource "cloudflare_dns_record" "keycloak_railway_verify" {
  zone_id = data.cloudflare_zone.main.id
  name    = "_railway-verify.keycloak"
  content = "railway-verify=321ff74d93180e8d2fbd9556d67ae3b23c951fa40e25905f11676e13c580df8e"
  type    = "TXT"
  ttl     = 300
}

resource "cloudflare_dns_record" "github_pages_challenge" {
  zone_id = data.cloudflare_zone.main.id
  name    = "_github-pages-challenge-zeroverify"
  content = "64d2eff6d779b349eb7527b2a1b325"
  type    = "TXT"
  ttl     = 300
}

resource "cloudflare_dns_record" "api_ns" {
  count = 4

  zone_id = data.cloudflare_zone.main.id
  name    = "api"
  content = var.api_name_servers[count.index]
  type    = "NS"
  ttl     = 300
}
