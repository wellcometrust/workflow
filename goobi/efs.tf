module "efs" {
  source = "git::https://github.com/wellcometrust/terraform.git//efs?ref=v11.4.0"

  name = "${var.name}"

  vpc_id  = "${var.vpc_id}"
  subnets = "${var.private_subnets}"

  num_subnets = "${var.num_private_subnets}"

  efs_access_security_group_ids = ["${aws_security_group.efs_security_group.id}"]
}
