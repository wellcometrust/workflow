resource "aws_ecs_cluster" "cluster" {
  name = "workflow"
}

module "load_balancer" {
  source = "../modules/load_balancer"

  name = "workflow"

  vpc_id         = module.network.vpc_id
  public_subnets = module.network.public_subnets

  certificate_domain = "workflow.wellcomecollection.org"

  service_lb_security_group_ids = [
    aws_security_group.service_lb.id,
    aws_security_group.interservice.id
  ]

  lb_controlled_ingress_cidrs = ["0.0.0.0/0"]
}

module "production_iam" {
  source = "../modules/production"
}

module "harvester" {
  source = "../modules/stack/harvester"

  name = "${local.environment_name}-harvester"

  configuration_bucket_name = aws_s3_bucket.workflow-configuration.bucket
  result_bucket_name        = aws_s3_bucket.workflow-harvesting-results.bucket

  cpu    = "1024"
  memory = "2048"

  cluster_arn = aws_ecs_cluster.cluster.arn

  subnets = module.network.private_subnets

  security_group_ids = [
    aws_security_group.service_egress.id,
    aws_security_group.interservice.id,
    aws_security_group.efs.id,
    aws_security_group.service_lb.id
  ]

  efs_id = module.efs.efs_id

  harvester_container_image = local.harvester_container_image
  proxy_container_image     = local.proxy_container_image

  db_server       = module.goobi_rds_cluster.host
  db_port         = module.goobi_rds_cluster.port
  db_name         = "harvester"
  db_user_key     = local.db_user_key
  db_password_key = local.db_password_key

  host_name    = var.domain_name
  path_pattern = "/harvester/*"
  source_ips   = local.harvester_source_ips

  vpc_id = module.network.vpc_id

  alb_listener_arn = module.load_balancer.https_listener_arn

  service_discovery_namespace_id = aws_service_discovery_private_dns_namespace.namespace.id
}

module "itm" {
  source = "../modules/stack/itm"

  name = "${local.environment_name}-itm"

  data_bucket_name          = aws_s3_bucket.workflow-data.bucket
  configuration_bucket_name = aws_s3_bucket.workflow-configuration.bucket

  cpu    = "1024"
  memory = "4096"

  cluster_arn = aws_ecs_cluster.cluster.arn

  subnets = module.network.private_subnets

  security_group_ids = [
    aws_security_group.service_egress.id,
    aws_security_group.interservice.id,
    aws_security_group.efs.id,
    aws_security_group.service_lb.id
  ]

  efs_id = module.efs.efs_id

  itm_container_image   = local.itm_container_image
  proxy_container_image = local.proxy_container_image

  db_server       = module.goobi_rds_cluster.host
  db_port         = module.goobi_rds_cluster.port
  db_name         = "itm"
  db_user_key     = local.db_user_key
  db_password_key = local.db_password_key

  host_name    = var.domain_name
  path_pattern = "/itm/*"
  source_ips   = local.itm_source_ips

  vpc_id = module.network.vpc_id

  alb_listener_arn = module.load_balancer.https_listener_arn

  service_discovery_namespace_id = aws_service_discovery_private_dns_namespace.namespace.id
}

module "goobi" {
  source = "../modules/stack/goobi"

  name = "${local.environment_name}-goobi"

  cpu    = "4096"
  memory = "8192"

  data_bucket_name          = aws_s3_bucket.workflow-data.bucket
  configuration_bucket_name = aws_s3_bucket.workflow-configuration.bucket

  cluster_arn = aws_ecs_cluster.cluster.arn

  subnets = module.network.private_subnets

  security_group_ids = [
    aws_security_group.service_egress.id,
    aws_security_group.interservice.id,
    aws_security_group.efs.id,
    aws_security_group.service_lb.id
  ]

  efs_id = module.efs.efs_id

  goobi_container_image = local.goobi_container_image
  proxy_container_image = local.proxy_container_image

  db_server       = module.goobi_rds_cluster.host
  db_port         = module.goobi_rds_cluster.port
  db_name         = "goobi"
  db_user_key     = local.db_user_key
  db_password_key = local.db_password_key

  host_name    = var.domain_name
  path_pattern = "/goobi/*"

  vpc_id = module.network.vpc_id

  alb_listener_arn = module.load_balancer.https_listener_arn

  service_discovery_namespace_id = aws_service_discovery_private_dns_namespace.namespace.id
}

# shell_server_1 handles altoconvert jobs and thus needs ~7GB of RAM
module "shell_server_1" {
  source = "../modules/stack/shell_server"

  name = "workflow-shellserver_1"

  cpu    = "2048"
  memory = "7168"

  configuration_bucket_name = aws_s3_bucket.workflow-configuration.bucket
  working_storage_path      = "/efs/tmp_shellserver1"
  data_bucket_name          = aws_s3_bucket.workflow-data.bucket
  configuration_file_path   = "/opt/digiverso/shellserver/conf/shellserver_1_config.properties"

  cluster_arn = aws_ecs_cluster.cluster.arn

  subnets = module.network.private_subnets

  security_group_ids = [
    aws_security_group.service_egress.id,
    aws_security_group.interservice.id,
    aws_security_group.efs.id
  ]

  efs_id = module.efs.efs_id

  shell_server_container_image = local.shell_server_container_image
}

# shell_server_2 handles bagit and iaparser jobs
module "shell_server_2" {
  source = "../modules/stack/shell_server"

  name = "workflow-shellserver_2"

  cpu    = "2048"
  memory = "3072"

  configuration_bucket_name = aws_s3_bucket.workflow-configuration.bucket
  working_storage_path      = "/efs/tmp_shellserver2"
  data_bucket_name          = aws_s3_bucket.workflow-data.bucket
  configuration_file_path   = "/opt/digiverso/shellserver/conf/shellserver_2_config.properties"

  cluster_arn = aws_ecs_cluster.cluster.arn

  subnets = module.network.private_subnets

  security_group_ids = [
    aws_security_group.service_egress.id,
    aws_security_group.interservice.id,
    aws_security_group.efs.id
  ]

  efs_id = module.efs.efs_id

  shell_server_container_image = local.shell_server_container_image
}

# shell_server_3 handles the jpeg conversion
module "shell_server_3" {
  source = "../modules/stack/shell_server"

  name = "workflow-shellserver_3"

  cpu    = "2048"
  memory = "3072"

  configuration_bucket_name = aws_s3_bucket.workflow-configuration.bucket
  working_storage_path      = "/efs/tmp_shellserver3"
  data_bucket_name          = aws_s3_bucket.workflow-data.bucket
  configuration_file_path   = "/opt/digiverso/shellserver/conf/shellserver_3_config.properties"

  cluster_arn = aws_ecs_cluster.cluster.arn

  subnets = module.network.private_subnets

  security_group_ids = [
    aws_security_group.service_egress.id,
    aws_security_group.interservice.id,
    aws_security_group.efs.id
  ]

  efs_id = module.efs.efs_id

  shell_server_container_image = local.shell_server_container_image
}

# shell_server_4 does the JP2 conversion with lurawave as well as JP2 validation with jpylyzer
module "shell_server_4" {
  source = "../modules/stack/shell_server"

  name = "workflow-shellserver_4"

  cpu    = "2048"
  memory = "3072"

  configuration_bucket_name = aws_s3_bucket.workflow-configuration.bucket
  working_storage_path      = "/efs/tmp_shellserver4"
  data_bucket_name          = aws_s3_bucket.workflow-data.bucket
  configuration_file_path   = "/opt/digiverso/shellserver/conf/shellserver_4_config.properties"

  cluster_arn = aws_ecs_cluster.cluster.arn

  subnets = module.network.private_subnets

  security_group_ids = [
    aws_security_group.service_egress.id,
    aws_security_group.interservice.id,
    aws_security_group.efs.id
  ]

  efs_id = module.efs.efs_id

  shell_server_container_image = local.shell_server_container_image
}
