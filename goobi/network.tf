module "network" {
  source     = "../../terraform-modules/network"
  name       = "${var.name}"
  cidr_block = "${var.vpc_cidr_block}"
  az_count   = "${var.az_count}"
}