module "efs" {
  source = "git::https://github.com/wellcometrust/terraform.git//efs?ref=v11.1.0"

  name = "${var.name}"

  vpc_id  = "${module.network.vpc_id}"
  subnets = "${module.network.private_subnets}"

  efs_access_security_group_ids = ["${aws_security_group.efs_security_group.id}"]
}