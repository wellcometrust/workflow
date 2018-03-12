module "ecs_service" {
  source = "git::https://github.com/wellcometrust/terraform-modules.git//ecs/service?ref=v6.4.0"
  name   = "goobi"

  cluster_id = "${module.ecs_cluster.cluster_name}"
  vpc_id     = "${module.network.vpc_id}"

  nginx_uri                = "${var.proxy_docker_uri}"
  app_uri                  = "${var.goobi_docker_uri}"
  primary_container_port   = "80"
  secondary_container_port = "8080"

  volume_name      = "goobi_metadata"
  volume_host_path = "/mnt/efs/digiverso/goobi/metadata"
  container_path   = "/opt/digiverso/goobi/metadata/"

  loadbalancer_cloudwatch_id = "${module.ecs_cluster.alb_cloudwatch_id}"

  listener_https_arn = "${module.ecs_cluster.alb_listener_https_arn}"
  listener_http_arn  = "${module.ecs_cluster.alb_listener_http_arn}"

  healthcheck_path = "/goobi/uii/index.xhtml"

  env_vars = {
    HTTPD_PORT   = "80"
    APP_PATH     = "goobi"
    APP_PORT     = "8080"
    SERVERNAME   = "${var.workflow_domain_name}"
    HTTPS_DOMAIN = "${var.workflow_domain_name}"
    DB_SERVER    = "${module.goobi_rds_cluster.host}"
    DB_PORT      = "${module.goobi_rds_cluster.port}"
    DB_NAME      = "${module.goobi_rds_cluster.database_name}"
    DB_USER      = "${module.goobi_rds_cluster.username}"
    DB_PASSWORD  = "${module.goobi_rds_cluster.password}"
  }

  https_domain = "${var.workflow_domain_name}"
  path_pattern = "/*"

  env_vars_length = 10

  server_error_alarm_topic_arn = "${module.alb_server_error_alarm.arn}"
  client_error_alarm_topic_arn = "${module.alb_client_error_alarm.arn}"

  log_group_name_prefix = "goobi"
}
