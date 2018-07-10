variable "name" {}
variable "task_desired_count" {
  default = "1"
}
variable "interservice_security_group_id" {}
variable "service_egress_security_group_id" {}

variable "cluster_id" {}
variable "vpc_id" {}
variable "private_subnets" {
  type = "list"
}
variable "namespace_id" {}

variable "region" {}
variable "efs_host_path" {}
variable "ebs_host_path" {}

variable "ebs_container_path" {}
variable "efs_container_path" {}

variable "cpu" {
  default = "1024"
}
variable "memory" {
  default = "1024"
}

# Load balancer

variable "healthcheck_path" {}

# App

variable "app_container_image" {}
variable "app_container_port" {}
variable "app_memory" {}
variable "app_cpu" {}
variable "app_env_vars" {
  type = "map"
}

# Sidecar

variable "sidecar_container_image" {}
variable "sidecar_container_port" {}
variable "sidecar_cpu" {}
variable "sidecar_memory" {}
variable "sidecar_env_vars" {
  type = "map"
}

# Load balancer

variable "alb_listener_arn" {}
variable "host_name" {}
variable "path_pattern" {}