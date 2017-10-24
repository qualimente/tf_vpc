resource "aws_vpc_endpoint" "private_s3" {
  vpc_id       = "${aws_vpc.main.id}"
  service_name = "com.amazonaws.${var.region}.s3"

  route_table_ids = [
    "${module.dmz_subnets.public_route_table_ids}",
    "${module.app_subnets.private_route_table_ids}",
    "${module.data_subnets.private_route_table_ids}",
    "${module.mgmt_subnets.private_route_table_ids}",
  ]
}
