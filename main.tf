module "goobi" {
  source = "goobi"

  # Goobi
  goobi_host_name    = "${var.domain_name}"
  goobi_path_pattern = "/goobi"

  goobi_app_container_image = "${var.goobi_app_container_image}"
  goobi_app_container_port  = "8009"

  goobi_app_env_vars = {
    DB_SERVER     = "${module.goobi_rds_cluster.host}"
    DB_PORT       = "${module.goobi_rds_cluster.port}"
    DB_NAME       = "${module.goobi_rds_cluster.database_name}"
    DB_USER       = "${module.goobi_rds_cluster.username}"
    DB_PASSWORD   = "${module.goobi_rds_cluster.password}"
    CONFIGSOURCE  = "s3"
    AWS_S3_BUCKET = "${aws_s3_bucket.workflow-configuration.bucket}"
    SERVERNAME    = "${var.domain_name}"
    HTTPS_DOMAIN  = "${var.domain_name}"
    APP_PATH      = "goobi"
    APP_CONTAINER = "app"
  }

  goobi_sidecar_container_image = "${var.goobi_sidecar_container_image}"
  goobi_sidecar_container_port  = "80"

  goobi_sidecar_env_vars = {
    SERVERNAME    = "${var.domain_name}"
    HTTPS_DOMAIN  = "${var.domain_name}"
    APP_PATH      = "goobi"
    APP_CONTAINER = "app"
  }

  goobi_efs_container_path = "/efs"
  goobi_ebs_container_path = "/ebs"

  goobi_app_cpu    = "512"
  goobi_app_memory = "2048"

  goobi_sidecar_cpu    = "128"
  goobi_sidecar_memory = "256"

  goobi_healthcheck_path = "/goobi/index.xhtml"

  # ITM
  itm_host_name    = "${var.domain_name}"
  itm_path_pattern = "/itm"

  itm_app_container_image = "${var.itm_app_container_image}"
  itm_app_container_port  = "8009"

  itm_app_env_vars = {
    DB_SERVER     = "${module.goobi_rds_cluster.host}"
    DB_PORT       = "${module.goobi_rds_cluster.port}"
    DB_NAME       = "${module.goobi_rds_cluster.database_name}"
    DB_USER       = "${module.goobi_rds_cluster.username}"
    DB_PASSWORD   = "${module.goobi_rds_cluster.password}"
    CONFIGSOURCE  = "s3"
    AWS_S3_BUCKET = "${aws_s3_bucket.workflow-configuration.bucket}"
    SERVERNAME    = "${var.domain_name}"
    HTTPS_DOMAIN  = "${var.domain_name}"
    APP_PATH      = "itm"
    APP_CONTAINER = "app"
  }

  itm_sidecar_container_image = "${var.itm_sidecar_container_image}"
  itm_sidecar_container_port  = "80"

  itm_sidecar_env_vars = {
    SERVERNAME    = "${var.domain_name}"
    HTTPS_DOMAIN  = "${var.domain_name}"
    APP_PATH      = "itm"
    APP_CONTAINER = "app"
  }

  itm_efs_container_path = "/efs"
  itm_ebs_container_path = "/ebs"

  itm_app_cpu    = "512"
  itm_app_memory = "1024"

  itm_sidecar_cpu    = "512"
  itm_sidecar_memory = "256"

  itm_healthcheck_path = "/itm/index.xhtml"

  # Shell Server
  shell_server_container_image = "${var.shell_server_container_image}"
  shell_server_container_port  = "80"

  shell_server_env_vars = {
    CONFIGSOURCE    = "s3"
    AWS_S3_BUCKET   = "${aws_s3_bucket.workflow-configuration.bucket}"
    WORKING_STORAGE = "/ebs"
    S3_DATA_BUCKET  = "${aws_s3_bucket.workflow-data.bucket}"
  }

  shell_server_efs_container_path = "/efs"
  shell_server_ebs_container_path = "/ebs"

  shell_server_cpu    = "512"
  shell_server_memory = "1024"

  controlled_access_cidr_ingress = ["${var.admin_cidr_ingress}"]

  asg_min     = "${var.asg_min}"
  asg_desired = "${var.asg_desired}"
  asg_max     = "${var.asg_max}"

  instance_type = "${var.instance_type}"
}
