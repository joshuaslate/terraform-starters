data "aws_acm_certificate" "ssl_cert" {
  domain   = "${var.api_domain_prefix}${var.environment_domain_prefix}${var.root_domain_name}"
  statuses = ["ISSUED"]
}
