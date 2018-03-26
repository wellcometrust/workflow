resource "aws_s3_bucket" "alb-logs" {
  bucket = "wellcomedigitalworkflow-alb-logs"
  acl    = "private"

  policy = "${data.aws_iam_policy_document.alb_logs.json}"

  lifecycle {
    prevent_destroy = true
  }

  lifecycle_rule {
    id      = "expire_alb_logs"
    enabled = true

    expiration {
      days = 30
    }
  }
}

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
