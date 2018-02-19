terraform {
  required_version = ">= 0.9"

  backend "s3" {
    bucket         = "wellcomecollection-workflow-infra"
    key            = "terraform/workflow.tfstate"
    dynamodb_table = "terraform-locktable"
    region         = "eu-west-1"
  }
}

provider "aws" {
  profile = "${var.profile}"
  region  = "${var.region}"
}
