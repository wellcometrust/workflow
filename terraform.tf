terraform {
  required_version = ">= 0.9"

  backend "s3" {
    bucket         = "wellcomecollection-workflow-infra"
    key            = "terraform/workflow.tfstate"
    dynamodb_table = "terraform-locktable"

    profile        = "wellcomedigitalworkflow"
    region         = "eu-west-1"
  }
}

provider "aws" {
  profile = "${var.profile}"
  region  = "${var.region}"
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

resource "aws_s3_bucket" "workflow-infra" {
  bucket = "wellcomecollection-workflow-infra"
  acl    = "private"

  lifecycle {
    prevent_destroy = true
  }
}
