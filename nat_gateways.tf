# Create NAT gateways in each of the DMZ subnets
resource "aws_eip" "nat" {
  vpc   = true
  count = "${length(var.dmz_subnet_cidrs)}"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = "${element(aws_eip.nat.*.id, count.index)}"
  subnet_id     = "${element(module.dmz_subnets.subnet_ids, count.index)}"
  count         = "${length(var.dmz_subnet_cidrs)}"
}
