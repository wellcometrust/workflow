data "aws_ssm_parameter" "admin_cidr_ingress" {
  name = "/workflow/config/prod/admin_cidr_ingress"
}

data "aws_ssm_parameter" "itm_source_ips" {
  name = "/workflow/config/prod/itm_source_ips"
}

data "aws_ssm_parameter" "harvester_source_ips" {
  name = "/workflow/config/prod/harvester_source_ips"
}

data "aws_ssm_parameter" "shell_server_container_image" {
  name = "/workflow/images/prod/shellserver"
}

data "aws_ssm_parameter" "goobi_container_image" {
  name = "/workflow/images/prod/goobi"
}

data "aws_ssm_parameter" "harvester_container_image" {
  name = "/workflow/images/prod/harvester"
}

data "aws_ssm_parameter" "itm_container_image" {
  name = "/workflow/images/prod/itm"
}

data "aws_ssm_parameter" "proxy_container_image" {
  name = "/workflow/images/prod/proxy"
}

data "aws_ssm_parameter" "lambda_api_endpoint_ep" {
  name = "/workflow/config/prod/lambda_api_endpoint_ep"
}

data "aws_ssm_parameter" "lambda_templateid_ep" {
  name = "/workflow/config/prod/lambda_templateid_ep"
}

data "aws_ssm_parameter" "lambda_updatetemplateid_ep" {
  name = "/workflow/config/prod/lambda_updatetemplateid_ep"
}

data "aws_ssm_parameter" "lambda_token_ep" {
  name = "/workflow/config/prod/lambda_token_ep"
}

data "aws_ssm_parameter" "lambda_api_endpoint_digitised" {
  name = "/workflow/config/prod/lambda_api_endpoint_digitised"
}

data "aws_ssm_parameter" "lambda_templateid_digitised" {
  name = "/workflow/config/prod/lambda_templateid_digitised"
}

data "aws_ssm_parameter" "lambda_updatetemplateid_digitised" {
  name = "/workflow/config/prod/lambda_updatetemplateid_digitised"
}

data "aws_ssm_parameter" "lambda_token_digitised" {
  name = "/workflow/config/prod/lambda_token_digitised"
}

# data "aws_ssm_parameter" "lambda_api_endpoint_av" {
#   name = "/workflow/config/prod/lambda_api_endpoint_av"
# }

# data "aws_ssm_parameter" "lambda_templateid_av" {
#   name = "/workflow/config/prod/lambda_templateid_av"
# }

# data "aws_ssm_parameter" "lambda_updatetemplateid_av" {
#   name = "/workflow/config/prod/lambda_updatetemplateid_av"
# }

# data "aws_ssm_parameter" "lambda_token_av" {
#   name = "/workflow/config/prod/lambda_token_av"
# }

data "aws_ssm_parameter" "rds_username" {
  name = "/aws/reference/secretsmanager/workflow/prod/rds_username"
}

data "aws_ssm_parameter" "rds_password" {
  name = "/aws/reference/secretsmanager/workflow/prod/rds_password"
}

locals {
  admin_cidr_ingress                = split(",", data.aws_ssm_parameter.admin_cidr_ingress.value)
  itm_source_ips                    = split(",", data.aws_ssm_parameter.itm_source_ips.value)
  harvester_source_ips              = split(",", data.aws_ssm_parameter.harvester_source_ips.value)
  shell_server_container_image      = data.aws_ssm_parameter.shell_server_container_image.value
  goobi_container_image             = data.aws_ssm_parameter.goobi_container_image.value
  harvester_container_image         = data.aws_ssm_parameter.harvester_container_image.value
  itm_container_image               = data.aws_ssm_parameter.itm_container_image.value
  proxy_container_image             = data.aws_ssm_parameter.proxy_container_image.value
  lambda_api_endpoint_ep            = data.aws_ssm_parameter.lambda_api_endpoint_ep.value
  lambda_templateid_ep              = data.aws_ssm_parameter.lambda_templateid_ep.value
  lambda_updatetemplateid_ep        = data.aws_ssm_parameter.lambda_updatetemplateid_ep.value
  lambda_token_ep                   = data.aws_ssm_parameter.lambda_token_ep.value
  lambda_api_endpoint_digitised     = data.aws_ssm_parameter.lambda_api_endpoint_digitised.value
  lambda_templateid_digitised       = data.aws_ssm_parameter.lambda_templateid_digitised.value
  lambda_updatetemplateid_digitised = data.aws_ssm_parameter.lambda_updatetemplateid_digitised.value
  lambda_token_digitised            = data.aws_ssm_parameter.lambda_token_digitised.value
  # lambda_api_endpoint_av            = data.aws_ssm_parameter.lambda_api_endpoint_av.value
  # lambda_templateid_av              = data.aws_ssm_parameter.lambda_templateid_av.value
  # lambda_updatetemplateid_av        = data.aws_ssm_parameter.lambda_updatetemplateid_av.value
  # lambda_token_av                   = data.aws_ssm_parameter.lambda_token_av.value
  rds_username = data.aws_ssm_parameter.rds_username.value
  rds_password = data.aws_ssm_parameter.rds_password.value
}
