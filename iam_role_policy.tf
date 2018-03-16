resource "aws_iam_role_policy" "platform_team_ecs_admin" {
  name   = "platform_team_ecs_admin"
  role   = "${aws_iam_role.platform_team_assume_role.name}"
  policy = "${data.aws_iam_policy_document.allow_ecs_admin.json}"
}

resource "aws_iam_role_policy" "platform_team_grafana_billing" {
  name   = "platform_team_grafana_billing_view"
  role   = "${aws_iam_role.platform_team_grafana_assume_role.name}"
  policy = "${data.aws_iam_policy_document.allow_billing_usage_view.json}"
}