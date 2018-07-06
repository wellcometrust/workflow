module "efs" {
  source = "../../terraform-modules/efs"

  name = "${var.name}"

  vpc_id  = "${module.network.vpc_id}"
  subnets = "${module.network.private_subnets}"

  efs_access_security_group_ids = ["${aws_security_group.efs_security_group.id}"]
}