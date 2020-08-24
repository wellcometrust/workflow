module "network" {
  source     = "../modules/network"
  name       = local.environment_name
  cidr_block = "10.50.0.0/16"
  az_count   = 3
}

