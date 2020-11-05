module "container_definition" {
  source = "git::https://github.com/wellcomecollection/terraform-aws-ecs-service.git//modules/container_definition?ref=v3.0.0"

  name  = var.name
  image = var.worker_node_container_image

  mount_points = [{
    containerPath = "/efs/"
    sourceVolume  = "efs"
  }]

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
    GOOBI_EXTERNAL_JOB_QUEUE     = var.goobi_external_job_queue
    GOOBI_EXTERNAL_COMMAND_QUEUE = var.goobi_external_status_queue
    WORKING_STORAGE              = var.working_storage_path
    S3_DATA_BUCKET               = var.data_bucket_name
    TZ                           = "Europe/London"
  }

}

module "task_definition" {
  source = "git::https://github.com/wellcomecollection/terraform-aws-ecs-service.git//modules/task_definition?ref=v3.0.0"

  cpu    = var.cpu
  memory = var.memory

  container_definitions = [
    module.container_definition.container_definition
  ]

  efs_volumes = [{
    name           = "efs"
    file_system_id = var.efs_id
    root_directory = "/"
  }]

  launch_types = ["FARGATE"]
  task_name    = var.name
}


module "service" {
  source = "git::https://github.com/wellcomecollection/terraform-aws-ecs-service.git//modules/service?ref=v3.0.0"

  cluster_arn  = var.cluster_arn
  service_name = var.name

  task_definition_arn = module.task_definition.arn

  container_name = module.container_definition.name
  subnets        = var.subnets

  security_group_ids = var.security_group_ids

  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 100
}
