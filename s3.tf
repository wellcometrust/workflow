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

resource "aws_s3_bucket_policy" "workflow-export-bagit-external-access-policy" {
  bucket = "${aws_s3_bucket.workflow-export-bagit.id}"
  policy = "${data.aws_iam_policy_document.allow_external_export-bagit_access.json}"
}

resource "aws_s3_bucket" "workflow-harvesting-results" {
  bucket = "wellcomecollection-workflow-harvesting-results"
  acl    = "private"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket" "workflow-upload" {
  bucket = "wellcomecollection-workflow-upload"
  acl    = "private"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_notification" "bucket_notification_workflow-upload" {
  bucket = "${aws_s3_bucket.workflow-upload.id}"

  lambda_function {
    lambda_function_arn = "${aws_lambda_function.lambda_s3_trigger_goobi_ep.arn}"
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "editorial/"
    filter_suffix       = ".zip"
  }

  lambda_function {
    lambda_function_arn = "${aws_lambda_function.lambda_s3_trigger_goobi_digitised.arn}"
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "digitised/"
    filter_suffix       = ".zip"
  }
}
