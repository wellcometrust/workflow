module "workflow-cluster_goobi_efs" {
  source = "git::https://github.com/wellcometrust/terraform.git//efs?ref=v7.0.0"

  name = "workflow-cluster_goobi_efs"

  vpc_id  = "${module.network.vpc_id}"
  subnets = ["${module.network.subnets}"]

  # Security group ID for ingress
  efs_access_security_group_ids = ["${module.ecs_cluster.asg_security_group_ids}"]
}
