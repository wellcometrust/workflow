output "itm_task_role" {
  value = "${module.itm.task_role}"
}

output "goobi_task_role" {
  value = "${module.goobi.task_role}"
}

output "goobi_target_group_arn" {
  value = "${module.goobi.target_group_arn}"
}

output "itm_target_group_arn" {
  value = "${module.itm.target_group_arn}"
}

output "harvester_target_group_arn" {
  value = "${module.harvester.target_group_arn}"
}

output "harvester_task_role" {
  value = "${module.harvester.task_role}"
}

output "shell_server_task_role" {
  value = "${module.shell_server.task_role}"
}


