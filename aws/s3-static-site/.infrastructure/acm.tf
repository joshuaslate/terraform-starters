# This provider is only to be used for ACM, which needs to be in the
# us-east-1 region due to CloudFront restrictions
provider "aws" {
  region  = "us-east-1"
  alias   = "acm_provider"
}

data "aws_acm_certificate" "ssl_cert" {
  provider = "aws.acm_provider"
  domain   = "${var.app_domain_prefix}${var.environment_domain_prefix}${var.root_domain_name}"
  statuses = ["ISSUED"]
}
