resource "aws_security_group" "efs" {
  name        = "workflow_efs_security_group"
  description = "Allow traffic between services and efs"
  vpc_id      = "${module.network.vpc_id}"

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "workflow-efs"
  }
}

resource "aws_security_group" "service_egress" {
  name        = "workflow_service_egress_security_group"
  description = "Allow traffic between services"
  vpc_id      = "${module.network.vpc_id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "workflow-egress"
  }
}

resource "aws_security_group" "interservice" {
  name        = "workflow_interservice_security_group"
  description = "Allow traffic between services"
  vpc_id      = "${module.network.vpc_id}"

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  tags {
    Name = "workflow-interservice"
  }
}

resource "aws_security_group" "service_lb" {
  name        = "workflow_service_lb_security_group"
  description = "Allow traffic between services and load balancer"
  vpc_id      = "${module.network.vpc_id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "workflow-service-lb"
  }
}
