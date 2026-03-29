output "zone_id" {
  description = "Route53 hosted zone ID for api subdomain"
  value       = aws_route53_zone.api.zone_id
}

output "name_servers" {
  description = "Route53 nameservers for api subdomain"
  value       = aws_route53_zone.api.name_servers
}
