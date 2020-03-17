# Network

variable "region" {
  default = "eu-west-1"
}

variable "controlled_access_cidr_ingress" {
  type = list(string)
}

variable "vpc_id" {
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "num_private_subnets" {
}

variable "service_egress_security_group_id" {
}

variable "interservice_security_group_id" {
}

variable "efs_security_group_id" {
}

variable "load_balancer_https_listener_arn" {
}

variable "service_lb_security_group_id" {
}

# Account

variable "profile" {
}

variable "key_name" {
  default = "wellcomedigitalworkflow"
}

variable "platform_team_account_id" {
  default = "760097843905"
}

variable "name" {
  default = "workflow"
}

variable "prefix" {
  type    = string
  default = ""
}
# Cluster

variable "asg_min" {
}

variable "asg_desired" {
}

variable "asg_max" {
}

variable "instance_type" {
}

variable "ebs_size" {
}

# Goobi

variable "goobi_app_container_image" {
}

variable "goobi_app_container_port" {
}

variable "goobi_app_env_vars" {
  type = map(string)
}

variable "goobi_app_env_vars_length" {
}

variable "goobi_sidecar_container_image" {
}

variable "goobi_sidecar_container_port" {
}

variable "goobi_sidecar_env_vars" {
  type = map(string)
}

variable "goobi_sidecar_env_vars_length" {
}

variable "goobi_ebs_container_path" {
}

variable "goobi_efs_container_path" {
}

variable "goobi_path_pattern" {
}

variable "goobi_host_name" {
}

variable "goobi_sidecar_cpu" {
}

variable "goobi_sidecar_memory" {
}

variable "goobi_app_cpu" {
}

variable "goobi_app_memory" {
}

variable "goobi_healthcheck_path" {
}

variable "goobi_deployment_minimum_healthy_percent" {
}

variable "goobi_deployment_maximum_percent" {
}

# ITM

variable "itm_app_container_image" {
}

variable "itm_app_container_port" {
}

variable "itm_app_env_vars" {
  type = map(string)
}

variable "itm_app_env_vars_length" {
}

variable "itm_sidecar_container_image" {
}

variable "itm_sidecar_container_port" {
}

variable "itm_sidecar_env_vars" {
  type = map(string)
}

variable "itm_sidecar_env_vars_length" {
}

variable "itm_ebs_container_path" {
}

variable "itm_efs_container_path" {
}

variable "itm_path_pattern" {
}

variable "itm_host_name" {
}

variable "itm_source_ips" {
  type = list(string)
}

variable "itm_sidecar_cpu" {
}

variable "itm_sidecar_memory" {
}

variable "itm_app_cpu" {
}

variable "itm_app_memory" {
}

variable "itm_healthcheck_path" {
}

variable "itm_deployment_minimum_healthy_percent" {
}

variable "itm_deployment_maximum_percent" {
}

# Harvester

variable "harvester_app_container_image" {
}

variable "harvester_app_container_port" {
}

variable "harvester_app_env_vars" {
  type = map(string)
}

variable "harvester_app_env_vars_length" {
}

variable "harvester_sidecar_container_image" {
}

variable "harvester_sidecar_container_port" {
}

variable "harvester_sidecar_env_vars" {
  type = map(string)
}

variable "harvester_sidecar_env_vars_length" {
}

variable "harvester_ebs_container_path" {
}

variable "harvester_efs_container_path" {
}

variable "harvester_path_pattern" {
}

variable "harvester_host_name" {
}

variable "harvester_source_ips" {
  type = list(string)
}

variable "harvester_sidecar_cpu" {
}

variable "harvester_sidecar_memory" {
}

variable "harvester_app_cpu" {
}

variable "harvester_app_memory" {
}

variable "harvester_healthcheck_path" {
}

variable "harvester_deployment_minimum_healthy_percent" {
}

variable "harvester_deployment_maximum_percent" {
}

