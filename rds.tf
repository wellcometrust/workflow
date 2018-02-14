module "goobi_rds_cluster" {
  source             = "git::https://github.com/wellcometrust/terraform.git//rds?ref=v6.4.1"
  cluster_identifier = "goobi"
  database_name      = "goobi"
  username           = "${var.rds_username}"
  password           = "${var.rds_password}"
  vpc_id             = "${module.network.vpc_id}"
  vpc_subnet_ids     = ["${module.network.subnets}"]

  admin_cidr_ingress       = "${var.admin_cidr_ingress}"
  db_access_security_group = "${module.ecs_cluster.asg_security_group_ids}"
  vpc_security_group_ids   = "${module.ecs_cluster.asg_security_group_ids}"
}
