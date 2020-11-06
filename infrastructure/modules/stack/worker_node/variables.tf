variable "name" {
  type = string
}

# variable "prefix" {
#   type = string
# }

variable "worker_node_container_image" {
  type = string
}

variable "goobi_external_job_queue" {
  type    = string
  default = "goobi_external"
}

variable "goobi_external_command_queue" {
  type    = string
  default = "goobi_command"
}

variable "working_storage_path" {
  type = string
}

variable "data_bucket_name" {
  type = string
}

variable "configuration_bucket_name" {
  type = string
}

variable "cpu" {
  type    = number
  default = 2048
}

variable "memory" {
  type    = number
  default = 4096
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
