resource "aws_cloudfront_distribution" "cloud" {
  count = length(var.cloudfront)

  origin {
    domain_name = lookup(var.cloudfront[count.index], "s3_domain_name")
    origin_id   = lookup(var.cloudfront[count.index], "origin_id", "myS3Origin")

    s3_origin_config {
      origin_access_identity = lookup(var.cloudfront[count.index], "oai")
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "blacklist"
      locations        = ["RU"]
    }
  }

  logging_config {
    include_cookies = false
    bucket          = lookup(var.cloudfront[count.index], "log_bucket")
    prefix          = lookup(var.cloudfront[count.index], "logging_prefix", "/log/cloudfront")
  }

  enabled             = true
  is_ipv6_enabled     = false
  default_root_object = "index.html"

  aliases = lookup(var.aliases[count.index], "aliases")

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = lookup(var.cloudfront[count.index], "origin_id", "myS3Origin")

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    viewer_protocol_policy = "redirect-to-https"
  }

  # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern     = "/"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = lookup(var.cloudfront[count.index], "origin_id", "myS3Origin")

    forwarded_values {
      query_string = false
      headers      = ["Origin"]

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  # Cache behavior with precedence 1
  ordered_cache_behavior {
    path_pattern     = "/content/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = lookup(var.cloudfront[count.index], "origin_id", "myS3Origin")

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  price_class = "PriceClass_200"

  tags = var.tags

  viewer_certificate {
    acm_certificate_arn      = lookup(var.cloudfront[count.index], "cert")
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = lookup(var.cloudfront[count.index], "ssl_suppport", "sni-only")
  }
}