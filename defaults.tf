variable "region" {
  default = "eu-west-1"
}

variable "profile" {
  default = "wellcomedigitalworkflow"
}

variable "admin_cidr_ingress" {
  type = "list"
}

variable "rds_admin_cidr_ingress" {}
variable "rds_password" {}
variable "rds_username" {}

variable "workflow_domain_name" {
  default = "workflow.wellcomecollection.org"
}
