variable "name" {}

variable "task_desired_count" {
  default = "1"
}

variable "deployment_minimum_healthy_percent" {
  default = "100"
}

variable "deployment_maximum_percent" {
  default = "200"
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

variable "container_port" {}
variable "container_image" {}

variable "ebs_container_path" {}
variable "efs_container_path" {}

variable "cpu" {}
variable "memory" {}

variable "env_vars" {
  type = "map"
}

variable "env_vars_length" {}
