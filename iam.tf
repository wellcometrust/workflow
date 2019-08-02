resource "aws_iam_role" "lambda_iam_role" {
  name               = "lambda_iam_role"
  assume_role_policy = "${data.aws_iam_policy_document.assume_lambda_role.json}"
}
