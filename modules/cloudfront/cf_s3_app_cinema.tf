resource "aws_cloudfront_origin_access_control" "cf_s3_app_cinema" {
  name                              = "${var.cloudfront_name}-oac"
  description                       = "OAC para acceso seguro a S3"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "cdn" {
  origin {
    domain_name              = var.s3_bucket_domain
    origin_id                = var.s3_origin_id
    origin_access_control_id = aws_cloudfront_origin_access_control.cf_s3_app_cinema.id
  }

  enabled             = true
  default_root_object = "index.html"

  default_cache_behavior {
    target_origin_id       = var.s3_origin_id
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    compress              = true

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = {
    Name        = var.cloudfront_name
    Environment = var.environment
  }
}
