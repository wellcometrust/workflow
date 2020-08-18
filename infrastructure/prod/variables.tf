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

variable "access_host_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "access_host_key_name" {
  type    = string
  default = "wellcomedigitalworkflow"
}