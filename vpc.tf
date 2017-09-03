provider "aws" {
  region = "${var.region}"
}

resource "aws_vpc" "main" {
  cidr_block                       = "${var.cidr_block}"
  enable_dns_support               = "${var.enable_dns_support}"
  enable_dns_hostnames             = "${var.enable_dns_hostnames}"
  assign_generated_ipv6_cidr_block = "false"
  instance_tenancy                 = "${var.instance_tenancy}"

  tags {
    Name        = "${var.name}"
    Environment = "${var.env}"
    ManagedBy   = "Terraform"
    Owner       = "${var.owner}"
  }
}

resource "aws_vpn_gateway" "remote_vgw" {
  count      = "${var.num_vpn_gateways}"
  vpc_id     = "${aws_vpc.main.id}"
  depends_on = ["aws_vpc.main"]

  tags {
    Name        = "vgw-${var.env}-${count.index}"
    ManagedBy   = "Terraform"
    Environment = "${var.env}"
    Description = "VPN gateway for connecting to a remote datacenter via, e.g. DirectConnect"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name        = "${var.name}"
    Environment = "${var.env}"
    ManagedBy   = "Terraform"
  }
}

module "dmz_subnets" {
  source = "git::ssh://git@github.com/terraform-community-modules/tf_aws_public_subnet?ref=v1.0.0"
  name   = "${var.env}-dmz"
  cidrs  = "${var.dmz_subnet_cidrs}"
  azs    = "${var.availability_zones}"
  vpc_id = "${aws_vpc.main.id}"
  igw_id = "${aws_internet_gateway.main.id}"

  map_public_ip_on_launch = "false"

  tags {
    "VPCName"     = "${var.name}"
    "ManagedBy"   = "Terraform"
    "Environment" = "${var.env}"
  }
}
