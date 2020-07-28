resource "aws_instance" "access_host" {
  ami           = data.aws_ami.amazon-linux-2.id
  instance_type = "t2.micro"
  key_name      = "wellcomedigitalworkflow"
  vpc_security_group_ids = [
    aws_security_group.ssh_controlled_ingress.id,
    aws_security_group.efs.id,
    aws_security_group.access_host_full_egress.id
  ]
  subnet_id                   = element(module.network.public_subnets, 0)
  associate_public_ip_address = true
  #   user_data = 
}

resource "aws_security_group" "ssh_controlled_ingress" {
  description = "controls direct access to application instances"
  vpc_id      = module.network.vpc_id
  name        = "${local.environment_name}_ssh_controlled_ingress_${random_id.sg_append.hex}"

  ingress {
    protocol  = "tcp"
    to_port   = 22
    from_port = 22

    cidr_blocks = var.admin_cidr_ingress
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "access_host_full_egress" {
  description = "allows full gress to access host"
  vpc_id      = module.network.vpc_id
  name        = "${local.environment_name}_access_host_full_egress_${random_id.sg_append.hex}"

  egress {
    protocol  = "-1"
    to_port   = 0
    from_port = 0

    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}
data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}


resource "random_id" "sg_append" {
  keepers = {
    sg_id = local.environment_name
  }

  byte_length = 8
}
