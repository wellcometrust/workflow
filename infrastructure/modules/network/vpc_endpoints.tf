data "aws_vpc_endpoint_service" "s3" {
  service = "s3"
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id          = aws_vpc.vpc.id
  service_name    = data.aws_vpc_endpoint_service.s3.service_name
  route_table_ids = aws_route_table.private_route_table.*.id
}
