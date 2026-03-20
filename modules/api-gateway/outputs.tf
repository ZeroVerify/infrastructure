output "api_ids" {
  value       = { for region, api in aws_apigatewayv2_api.api : region => api.id }
  description = "Map of region to HTTP API ID"
}

output "api_endpoints" {
  value       = { for region, api in aws_apigatewayv2_api.api : region => api.api_endpoint }
  description = "Map of region to default API endpoint"
}

output "log_group_names" {
  value       = { for region, log_group in aws_cloudwatch_log_group.api_gateway : region => log_group.name }
  description = "Map of region to API Gateway log group name"
}

output "log_group_arns" {
  value       = { for region, log_group in aws_cloudwatch_log_group.api_gateway : region => log_group.arn }
  description = "Map of region to API Gateway log group ARN"
}
