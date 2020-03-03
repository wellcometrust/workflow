# App configuration

variable "goobi_app_container_image" {
}

variable "goobi_sidecar_container_image" {
}

variable "itm_app_container_image" {
}

variable "itm_sidecar_container_image" {
}

variable "itm_source_ips" {
  type = list(string)
}

variable "harvester_app_container_image" {
}

variable "harvester_sidecar_container_image" {
}

variable "harvester_source_ips" {
  type = list(string)
}

variable "shell_server_container_image" {
}

# Lambda
variable "lambda_api_endpoint_ep" {
  type = string
}

variable "lambda_token_ep" {
  type = string
}

variable "lambda_templateid_ep" {
  type = string
}

variable "lambda_updatetemplateid_ep" {
  type = string
}

variable "lambda_hotfolder" {
  type    = string
  default = "hotfolder"
}

variable "lambda_api_endpoint_digitised" {
  type = string
}

variable "lambda_token_digitised" {
  type = string
}

variable "lambda_templateid_digitised" {
  type = string
}

variable "lambda_updatetemplateid_digitised" {
  type = string
}

# RDS

variable "rds_username" {
}

variable "rds_password" {
}

variable "rds_admin_cidr_ingress" {
}

variable "admin_cidr_ingress" {
  type = list(string)
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
  default = "workflow-dev"
}

variable "region" {
  default = "eu-west-1"
}

variable "domain_name" {
  default = "workflow.wellcomecollection.org"
}

variable "ep_upload_external_bucket" {
  default = "wellcomecollection-editorial-photography"
}

variable "storage_archive_bucket" {
  default = "wellcomecollection-storage-archive"
}

