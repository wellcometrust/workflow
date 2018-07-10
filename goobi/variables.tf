# Network

variable "region" {
  default = "eu-west-1"
}

variable "az_count" {
  default = "3"
}

variable "controlled_access_cidr_ingress" {
  type = "list"
}

variable "vpc_cidr_block" {
  default = "10.50.0.0/16"
}

# Account

variable "profile" {
  default = "wellcomedigitalworkflow"
}

variable "key_name" {
  default = "wellcomedigitalworkflow"
}

variable "platform_team_account_id" {
  default = "760097843905"
}

variable "workflow_domain_name" {
  default = "workflow.wellcomecollection.org"
}

variable "name" {
  default = "workflow"
}

# Cluster

variable "asg_min" {}
variable "asg_desired" {}
variable "asg_max" {}

variable "instance_type" {}

# Shell Server

variable "shell_server_ebs_container_path" {}
variable "shell_server_efs_container_path" {}
variable "shell_server_container_port" {}
variable "shell_server_container_image" {}

variable "shell_server_env_vars" {
  type = "map"
}

variable "shell_server_cpu" {}
variable "shell_server_memory" {}

# Goobi

variable "goobi_app_container_image" {}
variable "goobi_app_container_port" {}

variable "goobi_app_env_vars" {
  type = "map"
}

variable "goobi_sidecar_container_image" {}
variable "goobi_sidecar_container_port" {}

variable "goobi_sidecar_env_vars" {
  type = "map"
}

variable "goobi_ebs_container_path" {}
variable "goobi_efs_container_path" {}

variable "goobi_path_pattern" {}
variable "goobi_host_name" {}

variable "goobi_sidecar_cpu" {}
variable "goobi_sidecar_memory" {}
variable "goobi_app_cpu" {}
variable "goobi_app_memory" {}
variable "goobi_healthcheck_path" {}

# ITM

variable "itm_app_container_image" {}
variable "itm_app_container_port" {}

variable "itm_app_env_vars" {
  type = "map"
}

variable "itm_sidecar_container_image" {}
variable "itm_sidecar_container_port" {}

variable "itm_sidecar_env_vars" {
  type = "map"
}

variable "itm_ebs_container_path" {}
variable "itm_efs_container_path" {}

variable "itm_path_pattern" {}
variable "itm_host_name" {}

variable "itm_sidecar_cpu" {}
variable "itm_sidecar_memory" {}
variable "itm_app_cpu" {}
variable "itm_app_memory" {}
variable "itm_healthcheck_path" {}
