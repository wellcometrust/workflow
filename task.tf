//module "testtask" {
//  source = "git::https://github.com/wellcometrust/terraform-modules.git//ecs/service/ecs_task?ref=v6.4.0"
//  name = "testtask"
//  app_uri = "tutum/hello-world"
//  aws_region = "${var.region}"
//  primary_container_port = "443"
//  secondary_container_port = "80"
//  memory = 2048
//  cpu = 128
//  log_group_name_prefix = "goobitest"
//  service_vars = { NGINX_PORT = "443"
//    APP_PORT = "80"
//    HTTPS_DOMAIN = "intranda.com"
//  }
//  config_vars = { DUMMY = "DUMMY" }
//  config_vars_length = 1
//  container_path = "/tmp"
//}
