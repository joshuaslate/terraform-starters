resource "aws_cloudfront_distribution" "app_distribution" {
  origin {
    custom_origin_config {
      // These are all the defaults.
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }

    domain_name = "${aws_s3_bucket.app.website_endpoint}"
    origin_id   = "${var.app_domain_prefix}${var.environment_domain_prefix}${var.root_domain_name}"
  }

  enabled             = true
  default_root_object = "index.html"

  // All values are defaults from the AWS console.
  default_cache_behavior {
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    // This needs to match the `origin_id` above.
    target_origin_id       = "${var.app_domain_prefix}${var.environment_domain_prefix}${var.root_domain_name}"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  // Here we're ensuring we can hit this distribution from the domain
  aliases = ["${var.app_domain_prefix}${var.environment_domain_prefix}${var.root_domain_name}", "www.${var.app_domain_prefix}${var.environment_domain_prefix}${var.root_domain_name}"]

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  // SSL certificate from ACM
  viewer_certificate {
    acm_certificate_arn = "${data.aws_acm_certificate.ssl_cert.arn}"
    ssl_support_method  = "sni-only"
  }

  tags = {
    Project = "${var.project_name}"
  }
}