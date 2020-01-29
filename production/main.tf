// digital production s3 client accounts

data "aws_s3_bucket" "workflow_upload" {
  bucket = "wellcomecollection-workflow-upload"
}

// in_house_photography

resource "aws_iam_user" "in_house_photography" {
  name = "in_house_photography"
}

resource "aws_iam_access_key" "in_house_photography" {
  user = "${aws_iam_user.in_house_photography.name}"
}

resource "aws_iam_user_policy" "in_house_photography" {
  user   = "${aws_iam_user.in_house_photography.name}"
  policy = "${data.aws_iam_policy_document.in_house_photography.json}"
}

data "aws_iam_policy_document" "in_house_photography" {
  statement {
    actions = [
      "s3:*",
    ]

    resources = [
      "${data.aws_s3_bucket.workflow_upload.arn}/in_house_photography/*",
    ]
  }

  statement {
    actions = [
      "s3:List*",
    ]

    resources = [
      "${data.aws_s3_bucket.workflow_upload.arn}",
    ]
  }

  statement {
    actions = [
      "s3:*",
    ]

    resources = [
      "${data.aws_s3_bucket.workflow_upload.arn}/editorial/*",
    ]
  }
}

// in_house_archives

resource "aws_iam_user" "in_house_archives" {
  name = "in_house_archives"
}

resource "aws_iam_access_key" "in_house_archives" {
  user = "${aws_iam_user.in_house_archives.name}"
}

resource "aws_iam_user_policy" "in_house_archives" {
  user   = "${aws_iam_user.in_house_archives.name}"
  policy = "${data.aws_iam_policy_document.in_house_archives.json}"
}

data "aws_iam_policy_document" "in_house_archives" {
  statement {
    actions = [
      "s3:*",
    ]

    resources = [
      "${data.aws_s3_bucket.workflow_upload.arn}/in_house_archives/*",
    ]
  }

  statement {
    actions = [
      "s3:List*",
    ]

    resources = [
      "${data.aws_s3_bucket.workflow_upload.arn}",
    ]
  }

  statement {
    actions = [
      "s3:*",
    ]

    resources = [
      "${data.aws_s3_bucket.workflow_upload.arn}/editorial/*",
    ]
  }
}

// digitisation_services

resource "aws_iam_user" "digitisation_services" {
  name = "digitisation_services"
}

resource "aws_iam_access_key" "digitisation_services" {
  user = "${aws_iam_user.in_house_archives.name}"
}

resource "aws_iam_user_policy" "digitisation_services" {
  user   = "${aws_iam_user.digitisation_services.name}"
  policy = "${data.aws_iam_policy_document.digitisation_services.json}"
}

data "aws_iam_policy_document" "digitisation_services" {
  statement {
    actions = [
      "s3:*",
    ]

    resources = [
      "${data.aws_s3_bucket.workflow_upload.arn}/digitisation_services/*",
    ]
  }

  statement {
    actions = [
      "s3:List*",
    ]

    resources = [
      "${data.aws_s3_bucket.workflow_upload.arn}",
    ]
  }

  statement {
    actions = [
      "s3:*",
    ]

    resources = [
      "${data.aws_s3_bucket.workflow_upload.arn}/editorial/*",
    ]
  }
}
