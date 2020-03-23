module "network" {
  source     = "../modules/network"
  name       = "workflow-stage"
  cidr_block = "10.50.0.0/16"
  az_count   = 3
}

