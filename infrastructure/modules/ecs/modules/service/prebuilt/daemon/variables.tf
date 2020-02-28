variable "service_name" {
}

variable "ecs_cluster_id" {
}

variable "task_definition_arn" {
}

variable "vpc_id" {
}

variable "subnets" {
  type = list(string)
}

variable "security_group_ids" {
  type    = list(string)
  default = []
}

