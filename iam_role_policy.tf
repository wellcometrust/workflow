resource "aws_iam_role_policy" "ecs_goobi_s3_config_read" {
  role   = "${module.goobi.goobi_task_role}"
  policy = "${data.aws_iam_policy_document.s3_read_workflow-configuration.json}"
}

resource "aws_iam_role_policy" "ecs_goobi_s3_data_rw" {
  role   = "${module.goobi.goobi_task_role}"
  policy = "${data.aws_iam_policy_document.s3_rw_workflow-data.json}"
}

resource "aws_iam_role_policy" "ecs_goobi_s3_export_bagit_rw" {
  role   = "${module.goobi.goobi_task_role}"
  policy = "${data.aws_iam_policy_document.s3_rw_workflow-export-bagit.json}"
}

resource "aws_iam_role_policy" "ecs_goobi_s3_export_bagit_stage_rw" {
  role   = "${module.goobi.goobi_task_role}"
  policy = "${data.aws_iam_policy_document.s3_rw_workflow-export-bagit-stage.json}"
}

resource "aws_iam_role_policy" "ecs_goobi_s3_upload" {
  role   = "${module.goobi.goobi_task_role}"
  policy = "${data.aws_iam_policy_document.s3_workflow-upload.json}"
}

resource "aws_iam_role_policy" "ecs_goobi_s3_editorial_photography_upload_external" {
  role   = "${module.goobi.goobi_task_role}"
  policy = "${data.aws_iam_policy_document.s3_editorial_photography_upload_external.json}"
}

resource "aws_iam_role_policy" "ecs_goobi_s3_allow_storage_archive_access" {
  role   = "${module.goobi.goobi_task_role}"
  policy = "${data.aws_iam_policy_document.allow_storage_archive_access.json}"
}

resource "aws_iam_role_policy" "ecs_itm_s3_config_read" {
  role   = "${module.goobi.itm_task_role}"
  policy = "${data.aws_iam_policy_document.s3_read_workflow-configuration.json}"
}

resource "aws_iam_role_policy" "ecs_itm_s3_data_rw" {
  role   = "${module.goobi.itm_task_role}"
  policy = "${data.aws_iam_policy_document.s3_rw_workflow-data.json}"
}

resource "aws_iam_role_policy" "ecs_itm_s3_editorial_photography_upload_external" {
  role   = "${module.goobi.itm_task_role}"
  policy = "${data.aws_iam_policy_document.s3_editorial_photography_upload_external.json}"
}

resource "aws_iam_role_policy" "ecs_harvester_s3_config_read" {
  role   = "${module.goobi.harvester_task_role}"
  policy = "${data.aws_iam_policy_document.s3_read_workflow-configuration.json}"
}

resource "aws_iam_role_policy" "ecs_harvester_s3_rw_workflow-harvesting-results" {
  role   = "${module.goobi.harvester_task_role}"
  policy = "${data.aws_iam_policy_document.s3_rw_workflow-harvesting-results.json}"
}

# shell_server_1
resource "aws_iam_role_policy" "ecs_shell_server_1_s3_config_read" {
  role   = "${module.goobi.shell_server_1_task_role}"
  policy = "${data.aws_iam_policy_document.s3_read_workflow-configuration.json}"
}

resource "aws_iam_role_policy" "ecs_shell_server_1_s3_data_rw" {
  role   = "${module.goobi.shell_server_1_task_role}"
  policy = "${data.aws_iam_policy_document.s3_rw_workflow-data.json}"
}

resource "aws_iam_role_policy" "ecs_shell_server_1_s3_export_bagit_rw" {
  role   = "${module.goobi.shell_server_1_task_role}"
  policy = "${data.aws_iam_policy_document.s3_rw_workflow-export-bagit.json}"
}

resource "aws_iam_role_policy" "ecs_shell_server_1_s3_export_bagit_stage_rw" {
  role   = "${module.goobi.shell_server_1_task_role}"
  policy = "${data.aws_iam_policy_document.s3_rw_workflow-export-bagit-stage.json}"
}

resource "aws_iam_role_policy" "ecs_shell_server_1_s3_editorial_photography_upload_external" {
  role   = "${module.goobi.shell_server_1_task_role}"
  policy = "${data.aws_iam_policy_document.s3_editorial_photography_upload_external.json}"
}

# shell_server_2
resource "aws_iam_role_policy" "ecs_shell_server_2_s3_wellcomecollection_storage_read" {
  role   = "${module.goobi.shell_server_2_task_role}"
  policy = "${data.aws_iam_policy_document.s3_read_wellcomecollection-storage.json}"
}

resource "aws_iam_role_policy" "ecs_shell_server_2_s3_config_read" {
  role   = "${module.goobi.shell_server_2_task_role}"
  policy = "${data.aws_iam_policy_document.s3_read_workflow-configuration.json}"
}

resource "aws_iam_role_policy" "ecs_shell_server_2_s3_data_rw" {
  role   = "${module.goobi.shell_server_2_task_role}"
  policy = "${data.aws_iam_policy_document.s3_rw_workflow-data.json}"
}

resource "aws_iam_role_policy" "ecs_shell_server_2_s3_export_bagit_rw" {
  role   = "${module.goobi.shell_server_2_task_role}"
  policy = "${data.aws_iam_policy_document.s3_rw_workflow-export-bagit.json}"
}

resource "aws_iam_role_policy" "ecs_shell_server_2_s3_export_bagit_stage_rw" {
  role   = "${module.goobi.shell_server_2_task_role}"
  policy = "${data.aws_iam_policy_document.s3_rw_workflow-export-bagit-stage.json}"
}

resource "aws_iam_role_policy" "ecs_shell_server_2_s3_editorial_photography_upload_external" {
  role   = "${module.goobi.shell_server_2_task_role}"
  policy = "${data.aws_iam_policy_document.s3_editorial_photography_upload_external.json}"
}

# shell_server_3
resource "aws_iam_role_policy" "ecs_shell_server_3_s3_config_read" {
  role   = "${module.goobi.shell_server_3_task_role}"
  policy = "${data.aws_iam_policy_document.s3_read_workflow-configuration.json}"
}

resource "aws_iam_role_policy" "ecs_shell_server_3_s3_data_rw" {
  role   = "${module.goobi.shell_server_3_task_role}"
  policy = "${data.aws_iam_policy_document.s3_rw_workflow-data.json}"
}

resource "aws_iam_role_policy" "ecs_shell_server_3_s3_export_bagit_rw" {
  role   = "${module.goobi.shell_server_3_task_role}"
  policy = "${data.aws_iam_policy_document.s3_rw_workflow-export-bagit.json}"
}

resource "aws_iam_role_policy" "ecs_shell_server_3_s3_export_bagit_stage_rw" {
  role   = "${module.goobi.shell_server_3_task_role}"
  policy = "${data.aws_iam_policy_document.s3_rw_workflow-export-bagit-stage.json}"
}

resource "aws_iam_role_policy" "ecs_shell_server_3_s3_editorial_photography_upload_external" {
  role   = "${module.goobi.shell_server_3_task_role}"
  policy = "${data.aws_iam_policy_document.s3_editorial_photography_upload_external.json}"
}

# shell_server_4
resource "aws_iam_role_policy" "ecs_shell_server_4_s3_config_read" {
  role   = "${module.goobi.shell_server_4_task_role}"
  policy = "${data.aws_iam_policy_document.s3_read_workflow-configuration.json}"
}

resource "aws_iam_role_policy" "ecs_shell_server_4_s3_data_rw" {
  role   = "${module.goobi.shell_server_4_task_role}"
  policy = "${data.aws_iam_policy_document.s3_rw_workflow-data.json}"
}

resource "aws_iam_role_policy" "ecs_shell_server_4_s3_export_bagit_rw" {
  role   = "${module.goobi.shell_server_4_task_role}"
  policy = "${data.aws_iam_policy_document.s3_rw_workflow-export-bagit.json}"
}

resource "aws_iam_role_policy" "ecs_shell_server_4_s3_export_bagit_stage_rw" {
  role   = "${module.goobi.shell_server_4_task_role}"
  policy = "${data.aws_iam_policy_document.s3_rw_workflow-export-bagit-stage.json}"
}

resource "aws_iam_role_policy" "ecs_shell_server_4_s3_editorial_photography_upload_external" {
  role   = "${module.goobi.shell_server_4_task_role}"
  policy = "${data.aws_iam_policy_document.s3_editorial_photography_upload_external.json}"
}

resource "aws_iam_role_policy" "lambda_vpc_permissions" {
  name   = "lambda_vpc_permissions"
  role   = "${aws_iam_role.lambda_iam_role.name}"
  policy = "${data.aws_iam_policy_document.lambda_vpc_permissions.json}"
}

resource "aws_iam_role_policy" "lambda_s3_upload_rw" {
  name   = "lambda_s3_upload"
  role   = "${aws_iam_role.lambda_iam_role.name}"
  policy = "${data.aws_iam_policy_document.s3_workflow-upload.json}"
}

resource "aws_iam_role_policy" "cloudwatch_logs" {
  name   = "s3_trigger_goobi_lambda_logs"
  role   = "${aws_iam_role.lambda_iam_role.name}"
  policy = "${data.aws_iam_policy_document.cloudwatch_logs.json}"
}
