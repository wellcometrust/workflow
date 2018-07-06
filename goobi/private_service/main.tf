module "service" {
  source = "git::https://github.com/wellcometrust/terraform.git//ecs/modules/service/prebuilt/default?ref=v11.1.0"

  service_name       = "${var.name}"
  task_desired_count = "${var.task_desired_count}"

  task_definition_arn = "${module.task.task_definition_arn}"

  security_group_ids = ["${var.interservice_security_group_id}", "${var.service_egress_security_group_id}"]

  container_port = "${module.task.task_port}"

  ecs_cluster_id = "${var.cluster_id}"

  vpc_id  = "${var.vpc_id}"
  subnets = "${var.private_subnets}"

  namespace_id = "${var.namespace_id}"

  launch_type = "EC2"
}

module "task" {
  source = "git::https://github.com/wellcometrust/terraform.git//ecs/modules/task/prebuilt/single_container+ebs+efs?ref=v11.1.0"

  aws_region = "${var.region}"
  task_name  = "${var.name}"

  container_image = "${var.container_image}"
  container_port  = "${var.container_port}"

  efs_host_path      = "${var.efs_host_path}"
  efs_container_path = "${var.efs_container_path}"

  ebs_host_path      = "${var.ebs_host_path}"
  ebs_container_path = "${var.ebs_container_path}"

  cpu    = "${var.cpu}"
  memory = "${var.memory}"

  env_vars = "${var.env_vars}"
}