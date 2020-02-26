module "efs" {
  source = "../efs"

  name = "${var.name}"

  vpc_id  = "${var.vpc_id}"
  subnets = "${var.private_subnets}"

  num_subnets = "${var.num_private_subnets}"

  efs_access_security_group_ids = ["${var.efs_security_group_id}"]
}
