module "cluster" {
  source = "./cluster"

  name = var.name

  vpc_id          = var.vpc_id
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  region   = var.region
  key_name = var.key_name

  controlled_access_cidr_ingress = var.controlled_access_cidr_ingress

  efs_security_group_ids = [var.efs_security_group_id]
  efs_id                 = module.efs.efs_id

  cluster_name = aws_ecs_cluster.cluster.name

  asg_min     = var.asg_min
  asg_desired = var.asg_desired
  asg_max     = var.asg_max

  instance_type = var.instance_type

  ebs_size = var.ebs_size
}

module "goobi" {
  source = "./public_service"

  name = join("-", [var.name, "goobi"])

  vpc_id          = var.vpc_id
  private_subnets = var.private_subnets

  namespace_id = aws_service_discovery_private_dns_namespace.namespace.id

  app_container_image = var.goobi_app_container_image
  app_container_port  = var.goobi_app_container_port
  app_env_vars        = var.goobi_app_env_vars
  app_env_vars_length = var.goobi_app_env_vars_length

  sidecar_container_image = var.goobi_sidecar_container_image
  sidecar_container_port  = var.goobi_sidecar_container_port
  sidecar_env_vars        = var.goobi_sidecar_env_vars
  sidecar_env_vars_length = var.goobi_sidecar_env_vars_length

  ebs_container_path = var.goobi_ebs_container_path
  efs_container_path = var.goobi_efs_container_path

  ebs_host_path = module.cluster.ebs_host_path
  efs_host_path = module.cluster.efs_host_path

  service_egress_security_group_id = var.service_egress_security_group_id
  interservice_security_group_id   = var.interservice_security_group_id
  service_lb_security_group_id     = var.service_lb_security_group_id

  cluster_id = aws_ecs_cluster.cluster.id
  region     = var.region

  alb_listener_arn = var.load_balancer_https_listener_arn

  path_pattern = var.goobi_path_pattern
  host_name    = var.goobi_host_name

  sidecar_cpu    = var.goobi_sidecar_cpu
  sidecar_memory = var.goobi_sidecar_memory

  app_cpu    = var.goobi_app_cpu
  app_memory = var.goobi_app_memory

  cpu    = var.goobi_sidecar_cpu + var.goobi_app_cpu
  memory = var.goobi_sidecar_memory + var.goobi_app_memory

  healthcheck_path = var.goobi_healthcheck_path

  deployment_minimum_healthy_percent = var.goobi_deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.goobi_deployment_maximum_percent
}

module "itm" {
  source = "./public_service"

  name = join("-", [var.name, "itm"])

  vpc_id          = var.vpc_id
  private_subnets = var.private_subnets

  namespace_id = aws_service_discovery_private_dns_namespace.namespace.id

  app_container_image = var.itm_app_container_image
  app_container_port  = var.itm_app_container_port
  app_env_vars        = var.itm_app_env_vars
  app_env_vars_length = var.itm_app_env_vars_length

  sidecar_container_image = var.itm_sidecar_container_image
  sidecar_container_port  = var.itm_sidecar_container_port
  sidecar_env_vars        = var.itm_sidecar_env_vars
  sidecar_env_vars_length = var.itm_sidecar_env_vars_length

  ebs_container_path = var.itm_ebs_container_path
  efs_container_path = var.itm_efs_container_path

  ebs_host_path = module.cluster.ebs_host_path
  efs_host_path = module.cluster.efs_host_path

  service_egress_security_group_id = var.service_egress_security_group_id
  interservice_security_group_id   = var.interservice_security_group_id
  service_lb_security_group_id     = var.service_lb_security_group_id

  cluster_id = aws_ecs_cluster.cluster.id
  region     = var.region

  alb_listener_arn = var.load_balancer_https_listener_arn

  path_pattern = var.itm_path_pattern
  host_name    = var.itm_host_name
  source_ips   = var.itm_source_ips

  sidecar_cpu    = var.itm_sidecar_cpu
  sidecar_memory = var.itm_sidecar_memory

  app_cpu    = var.itm_app_cpu
  app_memory = var.itm_app_memory

  cpu    = var.itm_sidecar_cpu + var.itm_app_cpu
  memory = var.itm_sidecar_memory + var.itm_app_memory

  healthcheck_path = var.itm_healthcheck_path

  deployment_minimum_healthy_percent = var.itm_deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.itm_deployment_maximum_percent
}

module "harvester" {
  source = "./public_service"

  name = join("-", [var.name, "harvester"])

  vpc_id          = var.vpc_id
  private_subnets = var.private_subnets

  namespace_id = aws_service_discovery_private_dns_namespace.namespace.id

  app_container_image = var.harvester_app_container_image
  app_container_port  = var.harvester_app_container_port
  app_env_vars        = var.harvester_app_env_vars
  app_env_vars_length = var.harvester_app_env_vars_length

  sidecar_container_image = var.harvester_sidecar_container_image
  sidecar_container_port  = var.harvester_sidecar_container_port
  sidecar_env_vars        = var.harvester_sidecar_env_vars
  sidecar_env_vars_length = var.harvester_sidecar_env_vars_length

  ebs_container_path = var.harvester_ebs_container_path
  efs_container_path = var.harvester_efs_container_path

  ebs_host_path = module.cluster.ebs_host_path
  efs_host_path = module.cluster.efs_host_path

  service_egress_security_group_id = var.service_egress_security_group_id
  interservice_security_group_id   = var.interservice_security_group_id
  service_lb_security_group_id     = var.service_lb_security_group_id

  cluster_id = aws_ecs_cluster.cluster.id
  region     = var.region

  alb_listener_arn = var.load_balancer_https_listener_arn

  path_pattern = var.harvester_path_pattern
  host_name    = var.harvester_host_name
  source_ips   = var.harvester_source_ips

  sidecar_cpu    = var.harvester_sidecar_cpu
  sidecar_memory = var.harvester_sidecar_memory

  app_cpu    = var.harvester_app_cpu
  app_memory = var.harvester_app_memory

  cpu    = var.harvester_sidecar_cpu + var.harvester_app_cpu
  memory = var.harvester_sidecar_memory + var.harvester_app_memory

  healthcheck_path = var.harvester_healthcheck_path

  deployment_minimum_healthy_percent = var.harvester_deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.harvester_deployment_maximum_percent
}

