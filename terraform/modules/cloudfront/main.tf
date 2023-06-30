locals {
  s3_origin_id = "${var.env}s3"
}

resource "aws_cloudfront_origin_access_control" "main" {
  name                              = "cloudfront_s3_access_control"
  description                       = "Policy for CloudFront access bucket"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "main" {
  origin {
    domain_name              = var.bucket_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.main.id
    origin_id                = local.s3_origin_id
  }
  enabled             = true
  is_ipv6_enabled     = false
  comment             = "CloudFront For Bucket"
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE"]
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
