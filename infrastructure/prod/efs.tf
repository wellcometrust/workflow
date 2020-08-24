module "efs" {
  source = "../modules/efs"

  name = "workflow"

  vpc_id  = module.network.vpc_id
  subnets = module.network.private_subnets

  num_subnets = length(module.network.private_subnets)

  efs_access_security_group_ids = [aws_security_group.efs.id]
}
