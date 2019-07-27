# Edit the below
terraform {
  backend "s3" {
    bucket     = "terraform"
    key        = "ecs_fargate/tfstate"
    region     = "us-west-2"
    encrypt    = true
  }
}

provider "aws" {
  region = "${var.aws_region}"
}
