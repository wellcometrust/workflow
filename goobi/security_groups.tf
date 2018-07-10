resource "aws_security_group" "efs_security_group" {
  name        = "${var.name}_efs_security_group"
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
    Name = "${var.name}-efs"
  }
}

resource "aws_security_group" "service_egress_security_group" {
  name        = "${var.name}_service_egress_security_group"
  description = "Allow traffic between services"
  vpc_id      = "${module.network.vpc_id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.name}-egress"
  }
}

resource "aws_security_group" "interservice_security_group" {
  name        = "${var.name}_interservice_security_group"
  description = "Allow traffic between services"
  vpc_id      = "${module.network.vpc_id}"

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  tags {
    Name = "${var.name}-interservice"
  }
}