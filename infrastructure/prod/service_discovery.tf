resource "aws_service_discovery_private_dns_namespace" "namespace" {
  name = local.environment_name
  vpc  = module.network.vpc_id
}
