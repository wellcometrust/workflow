module "service" {
  source = "../../ecs/modules/service/prebuilt/load_balanced"

  service_name       = var.name
  task_desired_count = var.task_desired_count

  healthcheck_path = var.healthcheck_path

  task_definition_arn = module.task.task_definition_arn

  security_group_ids = [
    var.interservice_security_group_id,
    var.service_egress_security_group_id,
    var.service_lb_security_group_id,
  ]

  container_name = module.task.sidecar_task_name
  container_port = var.sidecar_container_port

  ecs_cluster_id = var.cluster_id

  vpc_id  = var.vpc_id
  subnets = var.private_subnets

  namespace_id = var.namespace_id

  launch_type = "EC2"

  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.deployment_maximum_percent
}

module "task" {
  source = "../../ecs/modules/task/prebuilt/container_with_sidecar+ebs+efs"

  aws_region = var.region
  task_name  = var.name

  efs_host_path      = var.efs_host_path
  efs_container_path = var.efs_container_path

  ebs_host_path      = var.ebs_host_path
  ebs_container_path = var.ebs_container_path

  cpu    = var.cpu
  memory = var.memory

  app_container_image = var.app_container_image
  app_container_port  = var.app_container_port

  app_memory = var.app_memory
  app_cpu    = var.app_cpu

  app_env_vars        = var.app_env_vars
  app_env_vars_length = var.app_env_vars_length

  sidecar_container_image = var.sidecar_container_image
  sidecar_container_port  = var.sidecar_container_port

  sidecar_cpu    = var.sidecar_cpu
  sidecar_memory = var.sidecar_memory

  sidecar_env_vars        = var.sidecar_env_vars
  sidecar_env_vars_length = var.sidecar_env_vars_length
}

