data "aws_iam_policy_document" "alb_logs" {
  statement {
    actions = [
      "s3:PutObject",
    ]

    resources = [
      "arn:aws:s3:::wellcomedigitalworkflow-alb-logs/*",
    ]

    principals {
      identifiers = ["arn:aws:iam::156460612806:root"]
      type        = "AWS"
    }
  }
}

# Platform team ecs access delegation
resource "aws_iam_role" "platform_team_assume_role" {
  name = "platform-team-assume-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Principal": {
      "AWS": "arn:aws:iam::${var.platform_team_account_id}:root"
    },
    "Action": "sts:AssumeRole"
  }
}
EOF
}

# Platform team grafana access delegation
resource "aws_iam_role" "platform_team_grafana_assume_role" {
  name = "platform-team-grafana-assume-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Principal": {
      "AWS": "arn:aws:iam::${var.platform_team_account_id}:root"
    },
    "Action": "sts:AssumeRole"
  }
}
EOF
}

data "aws_iam_policy_document" "allow_ecs_admin" {
  statement {
    actions = [
      "ecs:*",
      "ecr:*",
    ]

    resources = [
      "*",
    ]
  }
}

data "aws_iam_policy_document" "allow_billing_usage_view" {
  statement {
    actions = [
      "aws-portal:ViewBilling",
      "aws-portal:ViewUsage",
    ]

    resources = [
      "*",
    ]
  }
}

data "aws_iam_policy_document" "s3_read_workflow-configuration" {
  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket.workflow-configuration.arn}",
    ]
  }
}
