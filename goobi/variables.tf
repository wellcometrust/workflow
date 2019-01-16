# Network

variable "region" {
  default = "eu-west-1"
}

variable "controlled_access_cidr_ingress" {
  type = "list"
}

variable "vpc_id" {}

variable "public_subnets" {
  type = "list"
}

variable "private_subnets" {
  type = "list"
}

variable "num_private_subnets" {}

variable "service_egress_security_group_id" {}
variable "interservice_security_group_id" {}
variable "efs_security_group_id" {}

variable "load_balancer_https_listener_arn" {}

variable "service_lb_security_group_id" {}

# Account

variable "profile" {}

variable "key_name" {
  default = "wellcomedigitalworkflow"
}

variable "platform_team_account_id" {
  default = "760097843905"
}

variable "name" {
  default = "workflow"
}

# Cluster

variable "asg_min" {}
variable "asg_desired" {}
variable "asg_max" {}

variable "instance_type" {}

variable "ebs_size" {}

# Shell Server

variable "shell_server_ebs_container_path" {}
variable "shell_server_efs_container_path" {}
variable "shell_server_container_port" {}
variable "shell_server_container_image" {}

variable "shell_server_env_vars" {
  type = "map"
}

variable "shell_server_env_vars_length" {}

variable "shell_server_cpu" {}
variable "shell_server_memory" {}
variable "shell_server_deployment_minimum_healthy_percent" {}
variable "shell_server_deployment_maximum_percent" {}

# Goobi

variable "goobi_app_container_image" {}
variable "goobi_app_container_port" {}

variable "goobi_app_env_vars" {
  type = "map"
}

variable "goobi_app_env_vars_length" {}

variable "goobi_sidecar_container_image" {}
variable "goobi_sidecar_container_port" {}

variable "goobi_sidecar_env_vars" {
  type = "map"
}

variable "goobi_sidecar_env_vars_length" {}

variable "goobi_ebs_container_path" {}
variable "goobi_efs_container_path" {}

variable "goobi_path_pattern" {}
variable "goobi_host_name" {}

variable "goobi_sidecar_cpu" {}
variable "goobi_sidecar_memory" {}
variable "goobi_app_cpu" {}
variable "goobi_app_memory" {}
variable "goobi_healthcheck_path" {}

variable "goobi_deployment_minimum_healthy_percent" {}
variable "goobi_deployment_maximum_percent" {}

# ITM

variable "itm_app_container_image" {}
variable "itm_app_container_port" {}

variable "itm_app_env_vars" {
  type = "map"
}

variable "itm_app_env_vars_length" {}

variable "itm_sidecar_container_image" {}
variable "itm_sidecar_container_port" {}

variable "itm_sidecar_env_vars" {
  type = "map"
}

variable "itm_sidecar_env_vars_length" {}

variable "itm_ebs_container_path" {}
variable "itm_efs_container_path" {}

variable "itm_path_pattern" {}
variable "itm_host_name" {}

variable "itm_sidecar_cpu" {}
variable "itm_sidecar_memory" {}
variable "itm_app_cpu" {}
variable "itm_app_memory" {}
variable "itm_healthcheck_path" {}

variable "itm_deployment_minimum_healthy_percent" {}
variable "itm_deployment_maximum_percent" {}

# Harvester

variable "harvester_app_container_image" {}
variable "harvester_app_container_port" {}

variable "harvester_app_env_vars" {
  type = "map"
}

variable "harvester_app_env_vars_length" {}

variable "harvester_sidecar_container_image" {}
variable "harvester_sidecar_container_port" {}

variable "harvester_sidecar_env_vars" {
  type = "map"
}

variable "harvester_sidecar_env_vars_length" {}

variable "harvester_ebs_container_path" {}
variable "harvester_efs_container_path" {}

variable "harvester_path_pattern" {}
variable "harvester_host_name" {}

variable "harvester_sidecar_cpu" {}
variable "harvester_sidecar_memory" {}
variable "harvester_app_cpu" {}
variable "harvester_app_memory" {}
variable "harvester_healthcheck_path" {}

variable "harvester_deployment_minimum_healthy_percent" {}
variable "harvester_deployment_maximum_percent" {}
