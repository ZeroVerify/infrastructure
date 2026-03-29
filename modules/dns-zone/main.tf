resource "aws_route53_zone" "api" {
  name = "api.${var.domain_name}"

  tags = var.tags
}
