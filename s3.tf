resource "aws_s3_bucket" "workflow-configuration" {
  bucket = "wellcomedigitalworkflow-workflow-configuration"
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket" "workflow-data" {
  bucket = "wellcomedigitalworkflow-workflow-data"
  acl    = "private"

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

resource "aws_s3_bucket" "workflow-export-bagit" {
  bucket = "wellcomecollection-workflow-export-bagit"
  acl    = "private"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket" "workflow-harvesting-results" {
  bucket = "wellcomecollection-workflow-harvesting-results"
  acl    = "private"

  lifecycle {
    prevent_destroy = true
  }
}
