variable "name" {
  description = "Name of the VPC"
  type        = "string"
}

variable "env" {
  description = "Name of the 'environment' that the VPC supports, e.g. dev"
  type        = "string"
}

variable "owner" {
  description = "Organizational entity that 'owns' the VPC and is responsible for its care"
}

variable "region" {
  description = "The AWS region in which the VPC will be created."
  type        = "string"
}

variable "availability_zones" {
  description = "A list of availability zones to deploy the VPC across"
  type        = "list"
}

# Define a CIDR block for the VPC and Availability Zones within the VPC
# https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing
variable "cidr_block" {
  description = "The base CIDR block for the VPC; must be a /16"
  type        = "string"
}

variable "dmz_subnet_cidrs" {
  description = "list of cidr blocks for dmz subnets"
  type        = "list"
}

variable "app_subnet_cidrs" {
  description = "list of cidr blocks for app subnets"
  type        = "list"
}

variable "data_subnet_cidrs" {
  description = "list of cidr blocks for data subnets"
  type        = "list"
}

variable "mgmt_subnet_cidrs" {
  description = "list of cidr blocks for management subnets"
  type        = "list"
}

variable "num_vpn_gateways" {
  description = "The number of VPN gateways to provision for the VPC. Set to 1 or more if connecting VPC to a remote datacenter."
  default     = "0"
  type        = "string"
}

variable "enable_dns_hostnames" {
  description = "Launch instances in the VPC with public DNS hostnames. Details: http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/vpc-dns.html"
  default     = "false"
  type        = "string"
}

variable "enable_dns_support" {
  description = "Enable Amazon-managed DNS resolvers in the VPC.  Customize via DHCP options. Details: http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/vpc-dns.html"
  default     = "true"
  type        = "string"
}

variable "instance_tenancy" {
  description = "Control the tenancy of instances launched in the VPC; default is 'default' for shared hardware. Details: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/dedicated-instance.html"
  default     = "default"
  type        = "string"
}

output "vpc.id" {
  value = "${aws_vpc.main.id}"
}

output "vpc.cidr_block" {
  value = "${aws_vpc.main.cidr_block}"
}

output "nat_eips" {
  value = [
    "${aws_eip.nat.*.public_ip}",
  ]
}
