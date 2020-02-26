module "network" {
  source     = "git::https://github.com/wellcometrust/terraform.git//network?ref=workaround_count_computed"
  name       = "workflow"
  cidr_block = "10.50.0.0/16"
  az_count   = 3
}
