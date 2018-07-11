module "cluster" {
  source = "cluster"

  name = "${var.name}"

  vpc_id = "${module.network.vpc_id}"

  public_subnets  = "${module.network.public_subnets}"
  private_subnets = "${module.network.private_subnets}"

  region   = "${var.region}"
  key_name = "${var.key_name}"

  controlled_access_cidr_ingress = ["${var.controlled_access_cidr_ingress}"]

  efs_security_group_ids = ["${aws_security_group.efs_security_group.id}"]
  efs_id                 = "${module.efs.efs_id}"

  cluster_name = "${aws_ecs_cluster.cluster.name}"

  asg_min     = "${var.asg_min}"
  asg_desired = "${var.asg_desired}"
  asg_max     = "${var.asg_max}"

  instance_type = "${var.instance_type}"
}

module "shell_server" {
  source = "private_service"

  name = "shell_server"

  vpc_id       = "${module.network.vpc_id}"
  namespace_id = "${aws_service_discovery_private_dns_namespace.namespace.id}"

  ebs_container_path = "${var.shell_server_ebs_container_path}"
  efs_container_path = "${var.shell_server_efs_container_path}"

  ebs_host_path = "${module.cluster.ebs_host_path}"
  efs_host_path = "${module.cluster.efs_host_path}"

  container_port = "${var.shell_server_container_port}"

  service_egress_security_group_id = "${aws_security_group.service_egress_security_group.id}"
  interservice_security_group_id   = "${aws_security_group.interservice_security_group.id}"

  container_image = "${var.shell_server_container_image}"

  cluster_id = "${aws_ecs_cluster.cluster.id}"
  region     = "${var.region}"

  env_vars = "${var.shell_server_env_vars}"

  private_subnets = "${module.network.private_subnets}"

  cpu    = "${var.shell_server_cpu}"
  memory = "${var.shell_server_memory}"
}

module "load_balancer" {
  source = "load_balancer"

  name = "${var.name}"

  vpc_id         = "${module.network.vpc_id}"
  public_subnets = "${module.network.public_subnets}"

  certificate_domain = "${var.workflow_domain_name}"

  default_target_group_arn = "${module.goobi.target_group_arn}"

  service_lb_security_group_ids = [
    "${module.goobi.service_lb_security_group_id}",
    "${module.itm.service_lb_security_group_id}",
  ]
}

module "goobi" {
  source = "public_service"

  name = "goobi"

  vpc_id       = "${module.network.vpc_id}"
  namespace_id = "${aws_service_discovery_private_dns_namespace.namespace.id}"

  app_container_image = "${var.goobi_app_container_image}"
  app_container_port  = "${var.goobi_app_container_port}"
  app_env_vars        = "${var.goobi_app_env_vars}"

  sidecar_container_image = "${var.goobi_sidecar_container_image}"
  sidecar_container_port  = "${var.goobi_sidecar_container_port}"
  sidecar_env_vars        = "${var.goobi_sidecar_env_vars}"

  ebs_container_path = "${var.goobi_ebs_container_path}"
  efs_container_path = "${var.goobi_efs_container_path}"

  ebs_host_path = "${module.cluster.ebs_host_path}"
  efs_host_path = "${module.cluster.efs_host_path}"

  service_egress_security_group_id = "${aws_security_group.service_egress_security_group.id}"
  interservice_security_group_id   = "${aws_security_group.interservice_security_group.id}"

  cluster_id = "${aws_ecs_cluster.cluster.id}"
  region     = "${var.region}"

  private_subnets = "${module.network.private_subnets}"

  alb_listener_arn = "${module.load_balancer.https_listener_arn}"

  path_pattern = "${var.goobi_path_pattern}"
  host_name    = "${var.goobi_host_name}"

  sidecar_cpu    = "${var.goobi_sidecar_cpu}"
  sidecar_memory = "${var.goobi_sidecar_memory}"

  app_cpu    = "${var.goobi_app_cpu}"
  app_memory = "${var.goobi_app_memory}"

  cpu    = "${var.goobi_sidecar_cpu + var.goobi_app_cpu}"
  memory = "${var.goobi_sidecar_memory + var.goobi_app_memory}"

  healthcheck_path = "${var.goobi_healthcheck_path}"
}

module "itm" {
  source = "public_service"

  name = "itm"

  vpc_id       = "${module.network.vpc_id}"
  namespace_id = "${aws_service_discovery_private_dns_namespace.namespace.id}"

  app_container_image = "${var.itm_app_container_image}"
  app_container_port  = "${var.itm_app_container_port}"
  app_env_vars        = "${var.itm_app_env_vars}"

  sidecar_container_image = "${var.itm_sidecar_container_image}"
  sidecar_container_port  = "${var.itm_sidecar_container_port}"
  sidecar_env_vars        = "${var.itm_sidecar_env_vars}"

  ebs_container_path = "${var.itm_ebs_container_path}"
  efs_container_path = "${var.itm_efs_container_path}"

  ebs_host_path = "${module.cluster.ebs_host_path}"
  efs_host_path = "${module.cluster.efs_host_path}"

  service_egress_security_group_id = "${aws_security_group.service_egress_security_group.id}"
  interservice_security_group_id   = "${aws_security_group.interservice_security_group.id}"

  cluster_id = "${aws_ecs_cluster.cluster.id}"
  region     = "${var.region}"

  private_subnets  = "${module.network.private_subnets}"
  alb_listener_arn = "${module.load_balancer.https_listener_arn}"

  path_pattern = "${var.itm_path_pattern}"
  host_name    = "${var.itm_host_name}"

  sidecar_cpu    = "${var.itm_sidecar_cpu}"
  sidecar_memory = "${var.itm_sidecar_memory}"

  app_cpu    = "${var.itm_app_cpu}"
  app_memory = "${var.itm_app_memory}"

  cpu    = "${var.itm_sidecar_cpu + var.itm_app_cpu}"
  memory = "${var.itm_sidecar_memory + var.itm_app_memory}"

  healthcheck_path = "${var.itm_healthcheck_path}"
}
