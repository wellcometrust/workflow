module "network" {
  source     = "git::https://github.com/wellcometrust/terraform.git//network?ref=workaround_count_computed"
  name       = "${var.name}"
  cidr_block = "${var.vpc_cidr_block}"
  az_count   = "${var.az_count}"
}
