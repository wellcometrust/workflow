module "efs" {
  source = "git::https://github.com/wellcometrust/terraform.git//efs?ref=workaround_count_computed"

  name = "${var.name}"

  vpc_id      = "${module.network.vpc_id}"
  subnets     = "${module.network.private_subnets}"
  num_subnets = "${module.network.num_subnets}"

  efs_access_security_group_ids = ["${aws_security_group.efs_security_group.id}"]
}
