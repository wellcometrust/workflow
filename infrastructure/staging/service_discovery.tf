resource "aws_service_discovery_private_dns_namespace" "namespace" {
  name = "workflow-stage"
  vpc  = module.network.vpc_id
}
