resource "aws_alb_listener_rule" "https" {
  listener_arn = "${var.alb_listener_arn}"

  action {
    type             = "forward"
    target_group_arn = "${module.service.target_group_arn}"
  }

  condition {
    host_header {
      values = ["${var.host_name}"]
    }
  }

  condition {
    path_pattern {
      values = ["${var.path_pattern}"]
    }
  }

  condition {
    source_ip {
      values = "${var.source_ips}"
    }
  }

  lifecycle {
    ignore_changes = "all"
  }
}
