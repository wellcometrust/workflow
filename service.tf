module "ecs_service" {
  source = "git::https://github.com/wellcometrust/terraform-modules.git//ecs/service?ref=v6.4.0"
  name = "testservice"

  cluster_id = "${module.ecs_cluster.cluster_name}"
  vpc_id = "${module.network.vpc_id}"

  app_uri = "tutum/hello-world"
  secondary_container_port = "80"

  loadbalancer_cloudwatch_id = "${module.ecs_cluster.alb_cloudwatch_id}"

  listener_https_arn = "${module.ecs_cluster.alb_listener_https_arn}"
  listener_http_arn = "${module.ecs_cluster.alb_listener_http_arn}"

  healthcheck_path = "/"

  env_vars = {
    NGINX_PORT = "9000"
    APP_PORT = "80"
    HTTPS_DOMAIN = "goobi.wellcomecollection.org"
  }

  https_domain = "goobi.wellcomecollection.org"
  path_pattern = "/hello-world/*"

  env_vars_length = 3

  server_error_alarm_topic_arn = "${module.alb_server_error_alarm.arn}"
  client_error_alarm_topic_arn = "${module.alb_client_error_alarm.arn}"

  log_group_name_prefix = "goobi"
}