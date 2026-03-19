output "api_zone_id" {
  description = "Route53 hosted zone ID for api subdomain"
  value       = aws_route53_zone.api.zone_id
}

output "api_name_servers" {
  description = "Route53 nameservers for api subdomain (auto-configured in Cloudflare)"
  value       = aws_route53_zone.api.name_servers
}

output "api_zone_name" {
  description = "Domain name of the api subdomain hosted zone"
  value       = aws_route53_zone.api.name
}

output "cloudflare_zone_id" {
  description = "Cloudflare zone ID"
  value       = data.cloudflare_zone.main.id
}
