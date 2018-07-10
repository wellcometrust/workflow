module "network" {
  source     = "git::https://github.com/wellcometrust/terraform.git//network?ref=v11.1.0"
  name       = "${var.name}"
  cidr_block = "${var.vpc_cidr_block}"
  az_count   = "${var.az_count}"
}
