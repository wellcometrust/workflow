data "aws_ssm_parameter" "admin_cidr_ingress" {
  name = "/workflow/config/stage/admin_cidr_ingress"
}

data "aws_ssm_parameter" "itm_source_ips" {
  name = "/workflow/config/stage/itm_source_ips"
}

data "aws_ssm_parameter" "harvester_source_ips" {
  name = "/workflow/config/stage/harvester_source_ips"
}

data "aws_ssm_parameter" "shell_server_container_image" {
  name = "/workflow/images/stage/shellserver"
}

data "aws_ssm_parameter" "goobi_container_image" {
  name = "/workflow/images/stage/goobi"
}

data "aws_ssm_parameter" "harvester_container_image" {
  name = "/workflow/images/stage/harvester"
}

data "aws_ssm_parameter" "itm_container_image" {
  name = "/workflow/images/stage/itm"
}

data "aws_ssm_parameter" "proxy_container_image" {
  name = "/workflow/images/stage/proxy"
}

locals {
  admin_cidr_ingress           = "${split(",", data.aws_ssm_parameter.admin_cidr_ingress.value)}"
  itm_source_ips               = "${split(",", data.aws_ssm_parameter.itm_source_ips.value)}"
  harvester_source_ips         = "${split(",", data.aws_ssm_parameter.harvester_source_ips.value)}"
  shell_server_container_image = data.aws_ssm_parameter.shell_server_container_image.value
  goobi_container_image        = data.aws_ssm_parameter.goobi_container_image.value
  harvester_container_image    = data.aws_ssm_parameter.harvester_container_image.value
  itm_container_image          = data.aws_ssm_parameter.itm_container_image.value
  proxy_container_image        = data.aws_ssm_parameter.proxy_container_image.value
}
