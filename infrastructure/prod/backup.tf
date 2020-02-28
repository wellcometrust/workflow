resource "aws_backup_plan" "workflow-default" {
  name = "workflow-default"

  rule {
    rule_name         = "DailyBackups"
    target_vault_name = "${aws_backup_vault.workflow.name}"
    schedule          = "cron(0 5 ? * * *)"

    lifecycle {
      delete_after = "35"
    }
  }

  rule {
    rule_name         = "Monthly"
    target_vault_name = "${aws_backup_vault.workflow.name}"
    schedule          = "cron(0 5 1 * ? *)"

    lifecycle {
      cold_storage_after = "30"
      delete_after       = "180"
    }
  }
}

resource "aws_backup_vault" "workflow" {
  name = "workflow"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_iam_role" "aws_backup_default_role" {
  name = "aws_backup_default_role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "allow",
      "Principal": {
        "Service": ["backup.amazonaws.com"]
      }
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "aws_backup_role_assign" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = "${aws_iam_role.aws_backup_default_role.name}"
}

resource "aws_backup_selection" "workflow_default_backup_assignments" {
  name         = "workflow_default_backup_assignments"
  plan_id      = "${aws_backup_plan.workflow-default.id}"
  iam_role_arn = "${aws_iam_role.aws_backup_default_role.arn}"

  resources = [
    "${module.goobi.efs_arn}",
  ]

  selection_tag {
    type  = "STRINGEQUALS"
    key   = "backup-plan"
    value = "workflow-default"
  }
}
