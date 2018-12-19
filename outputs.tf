output "vpc_id" {
  value = "${module.network.vpc_id}"
}

output "public_subnets" {
  value = "${module.network.public_subnets}"
}

output "private_subnets" {
  value = "${module.network.private_subnets}"
}

output "num_private_subnets" {
  value = "${length(module.network.private_subnets)}"
}

output "service_egress_security_group_id" {
  value = "${aws_security_group.service_egress.id}"
}

output "interservice_security_group_id" {
  value = "${aws_security_group.interservice.id}"
}

output "efs_security_group_id" {
  value = "${aws_security_group.efs.id}"
}

output "service_lb_security_group_id" {
  value = "${aws_security_group.service_lb.id}"
}
