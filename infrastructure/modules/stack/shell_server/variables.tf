variable "name" {
  type = string
}

# variable "prefix" {
#   type = string
# }

variable "shell_server_container_image" {
  type = string
}

variable "configuration_bucket_name" {
  type = string
}

variable "working_storage_path" {
  type = string
}

variable "data_bucket_name" {
  type = string
}

variable "configuration_file_path" {
  type        = string
  description = "File path of configuration file as pulled from configuration bucket"
}

variable "cpu" {
  type    = number
  default = 1024
}

variable "memory" {
  type    = number
  default = 2048
}

variable "efs_id" {
  type = string
}

variable "cluster_arn" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}
