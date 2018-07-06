module "goobi" {
  source = "goobi"

  # Goobi
  goobi_host_name = "${var.domain_name}"
  goobi_path_pattern = "/goobi"

  goobi_app_container_image = "${var.goobi_app_container_image}"
  goobi_app_container_port = "8080"
  goobi_app_env_vars = {}

  goobi_sidecar_container_image = "${var.goobi_sidecar_container_image}"
  goobi_sidecar_container_port = "80"
  goobi_sidecar_env_vars = {}

  goobi_efs_container_path = "/efs"
  goobi_ebs_container_path = "/ebs"

  goobi_app_cpu = "512"
  goobi_app_memory = "1024"

  goobi_sidecar_cpu = "512"
  goobi_sidecar_memory = "1024"

  goobi_healthcheck_path = "/healthcheck"

  # ITM
  itm_host_name = "${var.domain_name}"
  itm_path_pattern = "/itm"

  itm_app_container_image = "${var.itm_app_container_image}"
  itm_app_container_port = "8080"
  itm_app_env_vars = {}

  itm_sidecar_container_image = "${var.itm_sidecar_container_image}"
  itm_sidecar_container_port = "80"
  itm_sidecar_env_vars = {}

  itm_efs_container_path = "/efs"
  itm_ebs_container_path = "/ebs"

  itm_app_cpu = "512"
  itm_app_memory = "1024"

  itm_sidecar_cpu = "512"
  itm_sidecar_memory = "1024"

  itm_healthcheck_path = "/healthcheck"

  # Shell Server
  shell_server_container_image = "${var.shell_server_container_image}"
  shell_server_container_port = "80"
  shell_server_env_vars = {}

  shell_server_efs_container_path = "/efs"
  shell_server_ebs_container_path = "/ebs"

  shell_server_cpu = "512"
  shell_server_memory = "1024"

  controlled_access_cidr_ingress = ["${var.admin_cidr_ingress}"]

  asg_min     = "${var.asg_min}"
  asg_desired = "${var.asg_desired}"
  asg_max     = "${var.asg_max}"

  instance_type = "${var.instance_type}"
}