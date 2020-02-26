resource "aws_s3_bucket" "workflow-configuration" {
  bucket = "wellcomedigitalworkflow-workflow-configuration"
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled = true

    noncurrent_version_expiration {
      days = 90
    }
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

  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled = true

    noncurrent_version_expiration {
      days = 60
    }
  }
}

resource "aws_s3_bucket" "workflow-infra" {
  bucket = "wellcomecollection-workflow-infra"
  acl    = "private"

  lifecycle {
    prevent_destroy = true
  }

  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled = true

    noncurrent_version_expiration {
      days = 60
    }
  }
}

resource "aws_s3_bucket" "workflow-export-bagit" {
  bucket = "wellcomecollection-workflow-export-bagit"
  acl    = "private"

  lifecycle {
    prevent_destroy = true
  }

  lifecycle_rule {
    id      = "expire_all_objects"
    enabled = true

    expiration {
      days = 10
    }
  }
}

resource "aws_s3_bucket_policy" "workflow-export-bagit-external-access-policy" {
  bucket = "${aws_s3_bucket.workflow-export-bagit.id}"
  policy = "${data.aws_iam_policy_document.allow_external_export-bagit_access.json}"
}

resource "aws_s3_bucket" "workflow-export-bagit-stage" {
  bucket = "wellcomecollection-workflow-export-bagit-stage"
  acl    = "private"

  lifecycle {
    prevent_destroy = true
  }

  lifecycle_rule {
    id      = "expire_all_objects"
    enabled = true

    expiration {
      days = 10
    }
  }
}

resource "aws_s3_bucket_policy" "workflow-export-bagit-stage-external-access-policy" {
  bucket = "${aws_s3_bucket.workflow-export-bagit-stage.id}"
  policy = "${data.aws_iam_policy_document.allow_external_export-bagit-stage_access.json}"
}

resource "aws_s3_bucket" "workflow-harvesting-results" {
  bucket = "wellcomecollection-workflow-harvesting-results"
  acl    = "private"

  lifecycle {
    prevent_destroy = true
  }

  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled = true

    noncurrent_version_expiration {
      days = 90
    }
  }
}

resource "aws_s3_bucket" "workflow-upload" {
  bucket = "wellcomecollection-workflow-upload"
  acl    = "private"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_policy" "workflow-upload" {
  bucket = "${aws_s3_bucket.workflow-upload.id}"
  policy = "${data.aws_iam_policy_document.workflow-upload.json}"
}

data "aws_iam_policy_document" "workflow-upload" {
  "statement" {
    actions = [
      "s3:List*",
      "s3:Get*",
      "s3:Delete*",
      "s3:Put*",
    ]

    resources = [
      "${aws_s3_bucket.workflow-upload.arn}",
      "${aws_s3_bucket.workflow-upload.arn}/*",
    ]

    principals {
      identifiers = [
        "arn:aws:iam::404315009621:role/digitisation-developer",
      ]

      type = "AWS"
    }
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
