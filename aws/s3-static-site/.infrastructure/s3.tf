resource "aws_s3_bucket" "app" {
  # The bucket name needs to match the full domain the app will be deployed at
  bucket = "${var.app_domain_prefix}${var.environment_domain_prefix}${var.root_domain_name}"
  acl    = "public-read"
  region = "${var.default_region}"

  policy = <<POLICY
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid":"AddPerm",
      "Effect":"Allow",
      "Principal": "*",
      "Action":["s3:GetObject"],
      "Resource":["arn:aws:s3:::${var.app_domain_prefix}${var.environment_domain_prefix}${var.root_domain_name}/*"]
    }
  ]
}
POLICY

  website {
    index_document = "index.html"
    # For single page applications (SPAs), error handling is likely handled by internal routing, so
    # index.html should be served in the case of a 404 as well, but this could be changed in the case
    # of a micro-frontend infrastructure.
    error_document = "index.html"
  }

  versioning {
    enabled = false
  }

  tags = {
    Project = "${var.project_name}"
  }
}
