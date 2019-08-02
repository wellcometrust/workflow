//locals {
//  storage_account_id = "975596993436"
//  storage_principal = "arn:aws:iam::${local.storage_account_id}:root"
//}
//
//resource "aws_vpc_endpoint_service" "goobi" {
//  acceptance_required        = false
//  network_load_balancer_arns = ["${aws_lb.goobi_internal.arn}"]
//
//  allowed_principals = [
//    "${local.storage_principal}",
//  ]
//}
//
//resource "aws_lb" "goobi_internal" {
//  name               = "libsys"
//  internal           = true
//  load_balancer_type = "network"
//  subnets            = ["${module.network.private_subnets}"]
//}
//
//resource "aws_lb_listener" "itm" {
//  load_balancer_arn = "${aws_lb.goobi_internal.arn}"
//  port              = "42421"
//  protocol          = "TCP"
//
//  default_action {
//    type             = "forward"
//    target_group_arn = "${module.goobi.itm_target_group_arn}"
//  }
//}
//
//resource "aws_lb_listener" "goobi" {
//  load_balancer_arn = "${aws_lb.goobi_internal.arn}"
//  port              = "42422"
//  protocol          = "TCP"
//
//  default_action {
//    type             = "forward"
//    target_group_arn = "${module.goobi.goobi_target_group_arn}"
//  }
//}
//
//resource "aws_lb_listener" "harvester" {
//  load_balancer_arn = "${aws_lb.goobi_internal.arn}"
//  port              = "42423"
//  protocol          = "TCP"
//
//  default_action {
//    type             = "forward"
//    target_group_arn = "${module.goobi.harvester_target_group_arn}"
//  }
//}