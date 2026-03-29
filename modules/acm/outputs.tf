output "certificate_arns" {
  description = "Map of region to validated ACM certificate ARN"
  value       = { for region, v in aws_acm_certificate_validation.api : region => v.certificate_arn }
}
