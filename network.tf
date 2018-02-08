module "network" {
  source     = "git::https://github.com/wellcometrust/terraform.git//network/"
  name       = "testnetwork"
  cidr_block = "10.50.0.0/16"
  az_count   = "2"
}
