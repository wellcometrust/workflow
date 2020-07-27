resource "aws_ecs_cluster" "cluster" {
  name = "workflow-stage"
}

module "load_balancer" {
  source = "../modules/load_balancer"

  name = "workflow-stage"

  vpc_id         = module.network.vpc_id
  public_subnets = module.network.public_subnets

  certificate_domain = "workflow.wellcomecollection.org"

  service_lb_security_group_ids = [
    aws_security_group.service_lb.id,
    aws_security_group.interservice.id
  ]

  lb_controlled_ingress_cidrs = ["0.0.0.0/0"]
}

# module "production_iam" {
#   source = "../modules/production"
# }

# the staging environment needs only one shellserver - it handles all jobtypes
module "shell_server_1" {
  source = "../modules/stack/shell_server"

  name = "workflow-stage-shellserver_1"

  cpu    = "1024"
  memory = "2048"

  configuration_bucket_name = aws_s3_bucket.workflow-stage-configuration.bucket
  working_storage_path      = "/efs/tmp_shellserver1"
  data_bucket_name          = aws_s3_bucket.workflow-stage-data.bucket
  configuration_file_path   = "/opt/digiverso/shellserver/conf/shellserver_1_config.properties"

  cluster_arn = aws_ecs_cluster.cluster.arn

  subnets = module.network.private_subnets

  security_group_ids = [
    aws_security_group.service_egress.id,
    aws_security_group.interservice.id,
    aws_security_group.efs.id
  ]

  efs_id = module.efs.efs_id

  shell_server_container_image = var.shell_server_container_image
}

module "harvester" {
  source = "../modules/stack/harvester"

  name = "workflow-stage-harvester"

  configuration_bucket_name = aws_s3_bucket.workflow-stage-configuration.bucket
  result_bucket_name        = aws_s3_bucket.workflow-stage-harvesting-results.bucket

  cluster_arn = aws_ecs_cluster.cluster.arn

  subnets = module.network.private_subnets

  security_group_ids = [
    aws_security_group.service_egress.id,
    aws_security_group.interservice.id,
    aws_security_group.efs.id,
    aws_security_group.service_lb.id
  ]

  efs_id = module.efs.efs_id

  harvester_container_image = var.harvester_container_image
  proxy_container_image     = var.proxy_container_image

  db_server   = module.goobi_rds_cluster.host
  db_port     = module.goobi_rds_cluster.port
  db_name     = "harvester"
  db_user     = module.goobi_rds_cluster.username
  db_password = module.goobi_rds_cluster.password

  host_name    = var.domain_name
  path_pattern = "/harvester/*"
  source_ips   = var.harvester_source_ips

  vpc_id = module.network.vpc_id

  alb_listener_arn = module.load_balancer.https_listener_arn
}

module "itm" {
  source = "../modules/stack/itm"

  name = "workflow-stage-itm"

  data_bucket_name          = aws_s3_bucket.workflow-stage-data.bucket
  configuration_bucket_name = aws_s3_bucket.workflow-stage-configuration.bucket

  cluster_arn = aws_ecs_cluster.cluster.arn

  subnets = module.network.private_subnets

  security_group_ids = [
    aws_security_group.service_egress.id,
    aws_security_group.interservice.id,
    aws_security_group.efs.id,
    aws_security_group.service_lb.id
  ]

  efs_id = module.efs.efs_id

  itm_container_image   = var.itm_container_image
  proxy_container_image = var.proxy_container_image

  db_server   = module.goobi_rds_cluster.host
  db_port     = module.goobi_rds_cluster.port
  db_name     = "itm"
  db_user     = module.goobi_rds_cluster.username
  db_password = module.goobi_rds_cluster.password

  host_name    = var.domain_name
  path_pattern = "/itm/*"
  source_ips   = var.itm_source_ips

  vpc_id = module.network.vpc_id

  alb_listener_arn = module.load_balancer.https_listener_arn
}

module "goobi" {
  source = "../modules/stack/goobi"

  name = "workflow-stage-goobi"

  data_bucket_name          = aws_s3_bucket.workflow-stage-data.bucket
  configuration_bucket_name = aws_s3_bucket.workflow-stage-configuration.bucket

  cluster_arn = aws_ecs_cluster.cluster.arn

  subnets = module.network.private_subnets

  security_group_ids = [
    aws_security_group.service_egress.id,
    aws_security_group.interservice.id,
    aws_security_group.efs.id,
    aws_security_group.service_lb.id
  ]

  efs_id = module.efs.efs_id

  goobi_container_image = var.goobi_container_image
  proxy_container_image = var.proxy_container_image

  db_server   = module.goobi_rds_cluster.host
  db_port     = module.goobi_rds_cluster.port
  db_name     = "goobi"
  db_user     = module.goobi_rds_cluster.username
  db_password = module.goobi_rds_cluster.password

  host_name    = var.domain_name
  path_pattern = "/goobi/*"

  vpc_id = module.network.vpc_id

  alb_listener_arn = module.load_balancer.https_listener_arn
}
