data "aws_route53_zone" "main" {
  name         = "${var.root_domain_name}"
  private_zone = false
}

// This Route53 record will point at our Application Load Balancer.
resource "aws_route53_record" "app_alias" {
  zone_id = "${data.aws_route53_zone.main.zone_id}"
  name    = "${var.api_domain_prefix}${var.environment_domain_prefix}${var.root_domain_name}"
  type    = "A"

  alias {
    name                   = "${aws_alb.main.dns_name}"
    zone_id                = "${aws_alb.main.zone_id}"
    evaluate_target_health = true
  }
}
