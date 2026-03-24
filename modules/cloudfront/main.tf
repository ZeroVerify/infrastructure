resource "aws_acm_certificate" "artifacts" {
  domain_name       = "artifacts.api.${var.domain_name}"
  validation_method = "DNS"

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "artifacts_cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.artifacts.domain_validation_options : dvo.domain_name => {
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

resource "aws_acm_certificate_validation" "artifacts" {
  certificate_arn         = aws_acm_certificate.artifacts.arn
  validation_record_fqdns = [for record in aws_route53_record.artifacts_cert_validation : record.fqdn]
}

resource "aws_cloudfront_distribution" "artifacts" {
  aliases = ["artifacts.api.${var.domain_name}"]
  enabled = true

  origin {
    domain_name = var.bucket_regional_domain_name
    origin_id   = "s3-artifacts"
  }

  default_cache_behavior {
    target_origin_id       = "s3-artifacts"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate_validation.artifacts.certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = var.tags
}

resource "aws_route53_record" "artifacts" {
  zone_id = var.api_zone_id
  name    = "artifacts.api.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.artifacts.domain_name
    zone_id                = aws_cloudfront_distribution.artifacts.hosted_zone_id
    evaluate_target_health = false
  }
}
