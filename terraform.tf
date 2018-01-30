terraform {
  required_version = ">= 0.9"
}

provider "aws" {
  profile = "${var.profile}"
  region  = "${var.region}"
}

