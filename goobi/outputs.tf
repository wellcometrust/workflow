output "itm_task_role" {
  value = "${module.itm.task_role}"
}

output "goobi_task_role" {
  value = "${module.goobi.task_role}"
}

output "shell_server_task_role" {
  value = "${module.shell_server.task_role}"
}

output "vpc_id" {
  value = "${module.network.vpc_id}"
}

output "public_subnets" {
  value = "${module.network.public_subnets}"
}

output "private_subnets" {
  value = "${module.network.private_subnets}"
}

output "interservice_security_group_id" {
  value = "${aws_security_group.interservice_security_group.id}"
}