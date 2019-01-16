# Assume role

resource "aws_iam_role" "assume_role" {
  name_prefix = "${var.namespace}"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role.json}"
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    principals {
      identifiers = ["arn:aws:iam::${var.account_id}:root"]
      type = "AWS"
    }

    actions = [
      "sts:AssumeRole",
    ]
  }
}

# Role policies

resource "aws_iam_role_policy" "ecs" {
  role   = "${aws_iam_role.assume_role.name}"
  policy = "${data.aws_iam_policy_document.ecs.json}"
}

resource "aws_iam_role_policy" "billing" {
  role   = "${aws_iam_role.assume_role.name}"
  policy = "${data.aws_iam_policy_document.billing.json}"
}

# Policy documents

data "aws_iam_policy_document" "ecs" {
  statement {
    actions = [
      "ecs:Describe*",
      "ecs:List*",
      "ecr:Get*",
      "ecr:Describe*",
      "ecr:List*"
    ]

    resources = [
      "*",
    ]
  }
}

data "aws_iam_policy_document" "billing" {
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