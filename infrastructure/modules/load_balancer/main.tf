resource "aws_alb" "load_balancer" {
  # This name can only contain alphanumerics and hyphens
  name = replace(var.name, "_", "-")

  subnets = var.public_subnets
  # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
  # force an interpolation expression to be interpreted as a list by wrapping it
  # in an extra set of list brackets. That form was supported for compatibility in
  # v0.11, but is no longer supported in Terraform v0.12.
  #
  # If the expression in the following list itself returns a list, remove the
  # brackets to avoid interpretation as a list of lists. If the expression
  # returns a single list item then leave it as-is and remove this TODO comment.
  security_groups = [concat(
    var.service_lb_security_group_ids,
    [aws_security_group.external_lb_security_group.id],
  )]
}

resource "aws_alb_listener" "https" {
  load_balancer_arn = aws_alb.load_balancer.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2015-05"
  certificate_arn   = data.aws_acm_certificate.certificate.arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "application/json"
      message_body = "Not Found"
      status_code  = "404"
    }
  }
}

data "aws_acm_certificate" "certificate" {
  domain      = var.certificate_domain
  statuses    = ["ISSUED"]
  most_recent = true
}

