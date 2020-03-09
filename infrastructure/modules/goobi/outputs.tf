output "itm_task_role" {
  value = module.itm.task_role
}

output "goobi_task_role" {
  value = module.goobi.task_role
}

output "goobi_target_group_arn" {
  value = module.goobi.target_group_arn
}

output "itm_target_group_arn" {
  value = module.itm.target_group_arn
}

output "harvester_target_group_arn" {
  value = module.harvester.target_group_arn
}

output "harvester_task_role" {
  value = module.harvester.task_role
}

output "efs_arn" {
  value = module.efs.efs_arn
}

output "goobi_namespace_id" {
  value = aws_service_discovery_private_dns_namespace.namespace.id
}

output "goobi_ebs_host_path" {
  value = module.cluster.ebs_host_path
}

output "goobi_efs_host_path" {
  value = module.cluster.efs_host_path
}

output "goobi_cluster_id" {
  value = aws_ecs_cluster.cluster.id
}