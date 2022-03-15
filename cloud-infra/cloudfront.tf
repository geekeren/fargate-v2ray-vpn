data "aws_cloudfront_cache_policy" "cache_disabled" {
  name = "Managed-CachingDisabled"
}

data "aws_cloudfront_origin_request_policy" "all_viewer" {
  name = "Managed-AllViewer"
}

resource "aws_cloudfront_distribution" "vpn" {
  price_class = "PriceClass_200"

  origin {
    domain_name = "${var.ddns_subdomain}.freemyip.com"
    origin_id   = "fargate"
    custom_origin_config {
      http_port                = 1080
      https_port               = 443
      origin_keepalive_timeout = 5
      origin_protocol_policy   = "http-only"
      origin_read_timeout      = 30
      origin_ssl_protocols = [
        "TLSv1",
        "TLSv1.1",
        "TLSv1.2",
      ]
    }
  }

  enabled         = true
  is_ipv6_enabled = false
  comment         = "VPN"

  default_cache_behavior {
    allowed_methods          = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods           = ["GET", "HEAD"]
    target_origin_id         = "fargate"
    viewer_protocol_policy   = "https-only"
    min_ttl                  = 0
    default_ttl              = 0
    max_ttl                  = 0
    cache_policy_id          = data.aws_cloudfront_cache_policy.cache_disabled.id
    origin_request_policy_id = data.aws_cloudfront_origin_request_policy.all_viewer.id
  }


  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["CN"]
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
