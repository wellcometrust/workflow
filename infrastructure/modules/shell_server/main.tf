module "shell_server" {
  source = "../goobi/private_service"

  name = var.name

  vpc_id          = var.vpc_id
  private_subnets = var.private_subnets

  namespace_id = var.shell_server_namespace_id

  ebs_container_path = var.shell_server_ebs_container_path
  efs_container_path = var.shell_server_efs_container_path

  ebs_host_path = var.ebs_host_path
  efs_host_path = var.efs_host_path

  container_port = var.shell_server_container_port

  service_egress_security_group_id = var.service_egress_security_group_id
  interservice_security_group_id   = var.interservice_security_group_id

  container_image = var.shell_server_container_image

  cluster_id = var.cluster_id
  region     = var.region

  env_vars        = var.shell_server_env_vars    
  env_vars_length = var.shell_server_env_vars_length

  cpu    = var.shell_server_cpu
  memory = var.shell_server_memory

  deployment_minimum_healthy_percent = var.shell_server_deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.shell_server_deployment_maximum_percent
}