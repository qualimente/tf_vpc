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
