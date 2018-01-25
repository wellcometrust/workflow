module "cluster_asg_on_demand" {
  source = "git::https://github.com/wellcometrust/terraform.git//ecs/cluster/asg"
  name   = "testcluster"

  subnet_list = ["${module.network.subnets}"]
  key_name    = "matthias-key"

  user_data          = "${module.cluster_userdata.rendered}"
  vpc_id             = "${module.network.vpc_id}"
  admin_cidr_ingress = "188.40.71.142/32"

  asg_min     = "1"
  asg_desired = "1"
  asg_max     = "1"

  image_id      = "${data.aws_ami.stable_coreos.id}"
  instance_type = "t2.large"

  sns_topic_arn         = "${module.testtopic.arn}"
  publish_to_sns_policy = "${module.testtopic.publish_policy}"

  alarm_topic_arn = "${module.testtopic.arn}"
}
