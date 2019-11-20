module "service" {
  source = "git::https://github.com/wellcometrust/terraform.git//ecs/modules/service/prebuilt/load_balanced?ref=v11.3.1"

  service_name       = "${var.name}"
  task_desired_count = "${var.task_desired_count}"

  healthcheck_path = "${var.healthcheck_path}"

  task_definition_arn = "${aws_ecs_task_definition.task.arn}"

  security_group_ids = [
    "${var.interservice_security_group_id}",
    "${var.service_egress_security_group_id}",
    "${var.service_lb_security_group_id}",
  ]

  container_name = "${module.task.sidecar_task_name}"
  container_port = "${var.sidecar_container_port}"

  ecs_cluster_id = "${var.cluster_id}"

  vpc_id  = "${var.vpc_id}"
  subnets = "${var.private_subnets}"

  namespace_id = "${var.namespace_id}"

  launch_type = "EC2"

  deployment_minimum_healthy_percent = "${var.deployment_minimum_healthy_percent}"
  deployment_maximum_percent         = "${var.deployment_maximum_percent}"
}
