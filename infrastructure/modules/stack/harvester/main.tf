module "app_container_definition" {
  source = "git::https://github.com/wellcomecollection/terraform-aws-ecs-service.git//modules/container_definition?ref=v3.0.0"

  name  = var.name
  image = var.harvester_container_image

  mount_points = [{
    containerPath = "/efs/"
    sourceVolume  = "efs"
  }]

  port_mappings = [
    {
      containerPort = var.container_port,
      hostPort      = var.container_port,
      protocol      = "tcp"
    }
  ]

  log_configuration = {
    logDriver = "awslogs"

    options = {
      "awslogs-group"         = "ecs/${var.name}",
      "awslogs-region"        = "eu-west-1",
      "awslogs-create-group"  = "true",
      "awslogs-stream-prefix" = "${var.name}"
    }

    secretOptions = null
  }

  environment = {
    CONFIGSOURCE                 = "s3"
    AWS_S3_BUCKET                = var.configuration_bucket_name
    TZ                           = "Europe/London"
    DB_SERVER                    = var.db_server
    DB_PORT                      = var.db_port
    DB_NAME                      = var.db_name
    DB_USER                      = var.db_user
    DB_PASSWORD                  = var.db_password
    DB_HA                        = "aurora:"
    S3_BUCKET_HARVESTING_RESULTS = var.result_bucket_name
    SERVERNAME                   = var.host_name
    HTTPS_DOMAIN                 = var.host_name
    APP_PATH                     = "harvester"
    APP_CONTAINER                = "localhost"
  }
}

module "proxy_container_definition" {
  source = "git::https://github.com/wellcomecollection/terraform-aws-ecs-service.git//modules/container_definition?ref=v3.0.0"

  name  = var.name
  image = var.proxy_container_image

  log_configuration = {
    logDriver = "awslogs"

    options = {
      "awslogs-group"         = "ecs/${var.name}",
      "awslogs-region"        = "eu-west-1",
      "awslogs-create-group"  = "true",
      "awslogs-stream-prefix" = "${var.name}"
    }

    secretOptions = null
  }

  environment = {
    SERVERNAME    = var.host_name
    HTTPS_DOMAIN  = var.host_name
    APP_PATH      = "harvester"
    APP_CONTAINER = "localhost"
    TZ            = "Europe/London"
  }
}

module "task_definition" {
  source = "git::https://github.com/wellcomecollection/terraform-aws-ecs-service.git//modules/task_definition?ref=v3.0.0"

  cpu    = var.cpu
  memory = var.memory

  container_definitions = [
    module.app_container_definition.container_definition,
    module.proxy_container_definition.container_definition
  ]

  efs_volumes = [{
    name           = "efs"
    file_system_id = var.efs_id
    root_directory = "/"
  }]

  launch_types = ["FARGATE"]
  task_name    = var.name
}

// TODO Port mappings

// TODO health check

module "service" {
  source = "git::https://github.com/wellcomecollection/terraform-aws-ecs-service.git//modules/service?ref=v3.0.0"

  cluster_arn  = var.cluster_arn
  service_name = var.name

  task_definition_arn = module.task_definition.arn

  container_name = module.app_container_definition.name
  subnets        = var.subnets

  service_discovery_namespace_id = var.service_discovery_namespace_id

  security_group_ids = var.security_group_ids

  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 100

  target_group_arn = aws_alb_target_group.harvester.arn

  container_port = var.container_port

}
