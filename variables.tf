# App configuration

variable "goobi_app_container_image" {}
variable "goobi_sidecar_container_image" {}

variable "itm_app_container_image" {}
variable "itm_sidecar_container_image" {}

variable "harvester_app_container_image" {}
variable "harvester_sidecar_container_image" {}

variable "shell_server_container_image" {}

# RDS

variable "rds_username" {}
variable "rds_password" {}
variable "rds_admin_cidr_ingress" {}

variable "admin_cidr_ingress" {
  type = "list"
}

# Cluster

variable "asg_min" {
  default = "1"
}

variable "asg_desired" {
  default = "1"
}

variable "asg_max" {
  default = "2"
}

variable "instance_type" {
  default = "c5.4xlarge"
}

variable "ebs_size" {
	default = "50"
}

# Misc

variable "profile" {
  default = "wellcomedigitalworkflow"
}

variable "region" {
  default = "eu-west-1"
}

variable "platform_team_account_id" {}

variable "domain_name" {
  default = "workflow.wellcomecollection.org"
}
