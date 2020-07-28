
# Lambda

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

variable "lambda_token_digitised" {
  type = string
}

variable "lambda_templateid_digitised" {
  type = string
}

variable "lambda_updatetemplateid_digitised" {
  type = string
}

variable "lambda_token_av" {
  type = string
}

variable "lambda_templateid_av" {
  type = string
}

variable "lambda_updatetemplateid_av" {
  type = string
}

# RDS

variable "rds_username" {
}

variable "rds_password" {
}


# Misc

variable "profile" {
  default = "workflow-dev"
}

variable "region" {
  default = "eu-west-1"
}

variable "domain_name" {
  default = "workflow-stage.wellcomecollection.org"
}

variable "ep_upload_external_bucket" {
  default = "wellcomecollection-editorial-photography"
}

variable "storage_archive_bucket" {
  default = "wellcomecollection-storage-staging"
}
