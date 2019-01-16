module "iam_monitoring" {
  source = "monitoring_iam"

  namespace = "platform"
  account_id = "${var.platform_team_account_id}"
}