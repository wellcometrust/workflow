module "goobi" {
  source = "goobi"

  vpc_id              = "${module.network.vpc_id}"
  public_subnets      = "${module.network.public_subnets}"
  private_subnets     = "${module.network.private_subnets}"
  num_private_subnets = "${length(module.network.private_subnets)}"

  # Goobi
  goobi_host_name    = "${var.domain_name}"
  goobi_path_pattern = "/goobi/*"

  goobi_app_container_image = "${var.goobi_app_container_image}"
  goobi_app_container_port  = "8009"

  goobi_app_env_vars = {
    DB_SERVER       = "${module.goobi_rds_cluster.host}"
    DB_PORT         = "${module.goobi_rds_cluster.port}"
    DB_NAME         = "${module.goobi_rds_cluster.database_name}"
    DB_USER         = "${module.goobi_rds_cluster.username}"
    DB_PASSWORD     = "${module.goobi_rds_cluster.password}"
    CONFIGSOURCE    = "s3"
    AWS_S3_BUCKET   = "${aws_s3_bucket.workflow-configuration.bucket}"
    SERVERNAME      = "${var.domain_name}"
    HTTPS_DOMAIN    = "${var.domain_name}"
    APP_PATH        = "goobi"
    APP_CONTAINER   = "localhost"
    S3_DATA_BUCKET  = "${aws_s3_bucket.workflow-data.bucket}"
    WORKING_STORAGE = "/ebs"
  }

  goobi_app_env_vars_length = "13"

  goobi_sidecar_container_image = "${var.goobi_sidecar_container_image}"
  goobi_sidecar_container_port  = "80"

  goobi_sidecar_env_vars = {
    SERVERNAME    = "${var.domain_name}"
    HTTPS_DOMAIN  = "${var.domain_name}"
    APP_PATH      = "goobi"
    APP_CONTAINER = "localhost"
  }

  goobi_sidecar_env_vars_length = "4"

  goobi_efs_container_path = "/efs"
  goobi_ebs_container_path = "/ebs"

  goobi_app_cpu    = "6144"
  goobi_app_memory = "7168"

  goobi_sidecar_cpu    = "128"
  goobi_sidecar_memory = "256"

  goobi_healthcheck_path = "/goobi/index.xhtml"

  goobi_deployment_minimum_healthy_percent = "0"
  goobi_deployment_maximum_percent         = "100"

  # ITM
  itm_host_name    = "${var.domain_name}"
  itm_path_pattern = "/itm/*"

  itm_app_container_image = "${var.itm_app_container_image}"
  itm_app_container_port  = "8009"

  itm_app_env_vars = {
    DB_SERVER       = "${module.goobi_rds_cluster.host}"
    DB_PORT         = "${module.goobi_rds_cluster.port}"
    DB_NAME         = "itm"
    DB_USER         = "${module.goobi_rds_cluster.username}"
    DB_PASSWORD     = "${module.goobi_rds_cluster.password}"
    CONFIGSOURCE    = "s3"
    AWS_S3_BUCKET   = "${aws_s3_bucket.workflow-configuration.bucket}"
    SERVERNAME      = "${var.domain_name}"
    HTTPS_DOMAIN    = "${var.domain_name}"
    APP_PATH        = "itm"
    APP_CONTAINER   = "localhost"
    WORKING_STORAGE = "/ebs"
    S3_DATA_BUCKET  = "${aws_s3_bucket.workflow-data.bucket}"
  }

  itm_app_env_vars_length = "13"

  itm_sidecar_container_image = "${var.itm_sidecar_container_image}"
  itm_sidecar_container_port  = "80"

  itm_sidecar_env_vars = {
    APP_CONTAINER = "localhost"
    SERVERNAME    = "${var.domain_name}"
    HTTPS_DOMAIN  = "${var.domain_name}"
    APP_PATH      = "itm"
  }

  itm_sidecar_env_vars_length = "4"

  itm_efs_container_path = "/efs"
  itm_ebs_container_path = "/ebs"

  itm_app_cpu    = "1024"
  itm_app_memory = "4096"

  itm_sidecar_cpu    = "128"
  itm_sidecar_memory = "256"

  itm_healthcheck_path = "/itm/service"

  itm_deployment_minimum_healthy_percent = "0"
  itm_deployment_maximum_percent         = "100"

  # Shell Server
  shell_server_container_image = "${var.shell_server_container_image}"
  shell_server_container_port  = "80"

  shell_server_env_vars = {
    CONFIGSOURCE    = "s3"
    AWS_S3_BUCKET   = "${aws_s3_bucket.workflow-configuration.bucket}"
    WORKING_STORAGE = "/ebs"
    S3_DATA_BUCKET  = "${aws_s3_bucket.workflow-data.bucket}"
  }

  shell_server_env_vars_length = "4"

  shell_server_efs_container_path = "/efs"
  shell_server_ebs_container_path = "/ebs"

  shell_server_cpu    = "1024"
  shell_server_memory = "7168"

  shell_server_deployment_minimum_healthy_percent = "0"
  shell_server_deployment_maximum_percent         = "100"

  controlled_access_cidr_ingress = ["${var.admin_cidr_ingress}"]

  asg_min     = "${var.asg_min}"
  asg_desired = "${var.asg_desired}"
  asg_max     = "${var.asg_max}"

  instance_type = "${var.instance_type}"

  ebs_size = "${var.ebs_size}"

  # harvester
  harvester_host_name    = "${var.domain_name}"
  harvester_path_pattern = "/harvester/*"

  harvester_app_container_image = "${var.harvester_app_container_image}"
  harvester_app_container_port  = "8009"

  harvester_app_env_vars = {
    DB_SERVER                    = "${module.goobi_rds_cluster.host}"
    DB_PORT                      = "${module.goobi_rds_cluster.port}"
    DB_NAME                      = "harvester"
    DB_USER                      = "${module.goobi_rds_cluster.username}"
    DB_PASSWORD                  = "${module.goobi_rds_cluster.password}"
    CONFIGSOURCE                 = "s3"
    AWS_S3_BUCKET                = "${aws_s3_bucket.workflow-configuration.bucket}"
    SERVERNAME                   = "${var.domain_name}"
    HTTPS_DOMAIN                 = "${var.domain_name}"
    APP_PATH                     = "harvester"
    APP_CONTAINER                = "localhost"
    S3_BUCKET_HARVESTING_RESULTS = "${aws_s3_bucket.workflow-harvesting-results.bucket}"
  }

  harvester_app_env_vars_length = "12"

  harvester_sidecar_container_image = "${var.harvester_sidecar_container_image}"
  harvester_sidecar_container_port  = "80"

  harvester_sidecar_env_vars = {
    SERVERNAME    = "${var.domain_name}"
    HTTPS_DOMAIN  = "${var.domain_name}"
    APP_PATH      = "harvester"
    APP_CONTAINER = "localhost"
  }

  harvester_sidecar_env_vars_length = "4"

  harvester_efs_container_path = "/efs"
  harvester_ebs_container_path = "/ebs"

  harvester_app_cpu    = "512"
  harvester_app_memory = "4096"

  harvester_sidecar_cpu    = "128"
  harvester_sidecar_memory = "256"

  harvester_healthcheck_path = "/harvester/index.xhtml"

  harvester_deployment_minimum_healthy_percent = "0"
  harvester_deployment_maximum_percent         = "100"
}
