resource "aws_cloudwatch_log_group" "api_gateway" {
  for_each = toset(concat([var.primary_region], var.replica_regions))

  region            = each.value
  name              = "/aws/apigateway/${var.project_name}-api-${each.value}"
  retention_in_days = var.log_retention_days

  tags = var.tags
}

resource "aws_apigatewayv2_api" "api" {
  for_each = toset(concat([var.primary_region], var.replica_regions))

  region        = each.value
  name          = "${var.project_name}-api-${each.value}"
  protocol_type = "HTTP"

  cors_configuration {
    allow_origins = var.allowed_origins
    allow_methods = ["POST", "OPTIONS"]
    allow_headers = ["Content-Type"]
    max_age       = 300
  }

  tags = var.tags
}

resource "aws_apigatewayv2_stage" "default" {
  for_each = toset(concat([var.primary_region], var.replica_regions))

  region      = each.value
  api_id      = aws_apigatewayv2_api.api[each.value].id
  name        = "$default"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gateway[each.value].arn
    format = jsonencode({
      requestId          = "$context.requestId"
      ip                 = "$context.identity.sourceIp"
      requestTime        = "$context.requestTime"
      httpMethod         = "$context.httpMethod"
      resourcePath       = "$context.resourcePath"
      status             = "$context.status"
      protocol           = "$context.protocol"
      responseLength     = "$context.responseLength"
      integrationLatency = "$context.integration.latency"
    })
  }

  tags = var.tags
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  for_each = {
    for combo in flatten([
      for region in concat([var.primary_region], var.replica_regions) : [
        for lambda_key, lambda_config in var.lambda_functions : {
          region     = region
          lambda_key = lambda_key
          config     = lambda_config
        }
      ]
    ]) : "${combo.region}/${combo.lambda_key}" => combo
  }

  region           = each.value.region
  api_id           = aws_apigatewayv2_api.api[each.value.region].id
  integration_type = "AWS_PROXY"
  integration_uri  = each.value.config.invoke_arn[each.value.region]

  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "api_routes" {
  for_each = {
    for combo in flatten([
      for region in concat([var.primary_region], var.replica_regions) : [
        for route_key, lambda_key in var.routes : {
          region     = region
          route_key  = route_key
          lambda_key = lambda_key
        }
      ]
    ]) : "${combo.region}/${combo.route_key}" => combo
  }

  region    = each.value.region
  api_id    = aws_apigatewayv2_api.api[each.value.region].id
  route_key = each.value.route_key
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration["${each.value.region}/${each.value.lambda_key}"].id}"
}

resource "aws_apigatewayv2_domain_name" "api" {
  for_each = toset(concat([var.primary_region], var.replica_regions))

  region      = each.value
  domain_name = "gw.api.${var.domain_name}"

  domain_name_configuration {
    certificate_arn = var.certificate_arns[each.value]
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }

  tags = var.tags
}

resource "aws_apigatewayv2_api_mapping" "api" {
  for_each = toset(concat([var.primary_region], var.replica_regions))

  region      = each.value
  api_id      = aws_apigatewayv2_api.api[each.value].id
  domain_name = aws_apigatewayv2_domain_name.api[each.value].id
  stage       = aws_apigatewayv2_stage.default[each.value].id
}

resource "aws_lambda_permission" "api_gateway_invoke" {
  for_each = {
    for combo in flatten([
      for region in concat([var.primary_region], var.replica_regions) : [
        for lambda_key, lambda_config in var.lambda_functions : {
          region     = region
          lambda_key = lambda_key
          config     = lambda_config
        }
      ]
    ]) : "${combo.region}/${combo.lambda_key}" => combo
  }

  region        = each.value.region
  statement_id  = "AllowAPIGatewayInvoke-${each.value.region}"
  action        = "lambda:InvokeFunction"
  function_name = each.value.config.function_name[each.value.region]
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.api[each.value.region].execution_arn}/*/*"
}
