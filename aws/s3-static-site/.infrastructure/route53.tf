data "aws_route53_zone" "app_zone" {
  name         = "${var.root_domain_name}"
  private_zone = false
}

// This Route53 record will point at our CloudFront distribution (app).
resource "aws_route53_record" "app_alias" {
  zone_id = "${data.aws_route53_zone.app_zone.zone_id}"
  name    = "${var.app_domain_prefix}${var.environment_domain_prefix}${var.root_domain_name}"
  type    = "A"

  alias {
    name                   = "${aws_cloudfront_distribution.app_distribution.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.app_distribution.hosted_zone_id}"
    evaluate_target_health = false
  }
}
