provider "aws" {
  profile = "${var.profile}"
  region  = "${var.region}"

  version = "1.22.0"
}

terraform {
  required_version = ">= 0.9"

  backend "s3" {
    bucket         = "wellcomecollection-workflow-infra"
    key            = "terraform/workflow.tfstate"
    dynamodb_table = "terraform-locktable"

    profile = "wellcomedigitalworkflow"
    region  = "eu-west-1"
  }
}

resource "aws_dynamodb_table" "terraform-locktable" {
  name           = "terraform-locktable"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  lifecycle {
    prevent_destroy = true
  }
}
