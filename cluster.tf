module "ecs_cluster" {
  source = "git::https://github.com/wellcometrust/terraform-modules.git//ecs/cluster?ref=v10.2.0"
  name   = "workflow-cluster"

  key_name           = "wellcomedigitalworkflow"
  admin_cidr_ingress = "${var.admin_cidr_ingress}"

  asg_on_demand_min     = 1
  asg_on_demand_desired = 1
  asg_on_demand_max     = 2

  asg_on_demand_instance_type = "t2.medium"

  asg_spot_min     = 0
  asg_spot_desired = 0
  asg_spot_max     = 1

  asg_spot_instance_type = "t2.medium"
  asg_spot_price         = 0.1

  vpc_id      = "${module.network.vpc_id}"
  vpc_subnets = ["${module.network.subnets}"]

  alb_certificate_domain = "${var.workflow_domain_name}"
  alb_log_bucket_id      = "${aws_s3_bucket.alb-logs.id}"

  ec2_terminating_topic_arn                       = "${module.ec2_terminating_topic.arn}"
  ec2_terminating_topic_publish_policy            = "${module.ec2_terminating_topic.publish_policy}"
  ec2_instance_terminating_for_too_long_alarm_arn = "${module.ec2_instance_terminating_for_too_long_alarm.arn}"

  efs_filesystem_id     = "${module.workflow-cluster_goobi_efs.efs_id}"
  ebs_device_name       = "/dev/xvdb"
  ebs_size              = 180
  log_retention_in_days = 60
}
