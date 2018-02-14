module "ecs_cluster" {
  #source = "git::https://github.com/wellcometrust/terraform-modules.git//ecs/cluster?ref=v6.4.1"
  source = "git::https://github.com/wellcometrust/terraform-modules.git//ecs/cluster?ref=allow_efs_mount_in_ecs_cluster"
  name   = "testcluster"

  key_name           = "wellcomedigitalworkflow"
  admin_cidr_ingress = "${var.admin_cidr_ingress}"

  asg_on_demand_min = 1
  asg_on_demand_desired = 1
  asg_on_demand_max = 2

  asg_on_demand_instance_type = "t2.large"

  asg_spot_min = 0
  asg_spot_desired = 0
  asg_spot_max = 1

  asg_spot_instance_type = "t2.large"
  asg_spot_price = 0.1

  vpc_id = "${module.network.vpc_id}"
  vpc_subnets = ["${module.network.subnets}"]

  alb_certificate_domain = "goobi.wellcomecollection.org"
  alb_log_bucket_id = "${aws_s3_bucket.alb-logs.id}"

  ec2_terminating_topic_arn = "${module.ec2_terminating_topic.arn}"
  ec2_terminating_topic_publish_policy = "${module.ec2_terminating_topic.publish_policy}"
  ec2_instance_terminating_for_too_long_alarm_arn = "${module.ec2_instance_terminating_for_too_long_alarm.arn}"

  efs_filesystem_id = "${module.testcluster_goobi_efs.efs_id}"
}
