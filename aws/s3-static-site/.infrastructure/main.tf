# Modify the below
terraform {
  backend "s3" {
    bucket     = "terraform"
    key        = "app/tfstate"
    region     = "us-west-2"
    encrypt  = true
  }
}

provider "aws" {
  region     = "${var.default_region}"
}
