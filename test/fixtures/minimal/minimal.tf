// Instantiate a minimal version of the module for testing

module "it_minimal" {
  source = "../../../" //minimal integration test

  name               = "${var.name}"
  env                = "${var.env}"
  region             = "${var.region}"
  cidr_block         = "${var.cidr_block}"
  dmz_subnet_cidrs   = "${var.dmz_subnet_cidrs}"
  app_subnet_cidrs   = "${var.app_subnet_cidrs}"
  data_subnet_cidrs  = "${var.data_subnet_cidrs}"
  mgmt_subnet_cidrs  = "${var.mgmt_subnet_cidrs}"
  availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]
  owner              = "${var.owner}"
}

variable "name" {
  type = "string"
}

variable "env" {
  type = "string"
}

variable "owner" {
  type = "string"
}

variable "region" {
  type = "string"
}

variable "availability_zones" {
  type = "list"
}

variable "cidr_block" {
  type = "string"
}

variable "dmz_subnet_cidrs" {
  type = "list"
}

variable "app_subnet_cidrs" {
  type = "list"
}

variable "data_subnet_cidrs" {
  type = "list"
}

variable "mgmt_subnet_cidrs" {
  type = "list"
}
