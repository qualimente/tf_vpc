// Instantiate a minimal version of the module for testing

//resource "aws_instance" "invalid_instance_type" {
//  ami           = "ami-b73b63a0"
//  instance_type = "t1.2xlarge" # invalid type!
//}

module "it_minimal" {
  source = "../../../" //minimal integration test

  name               = "test-vpc"
  env                = "test-env"
  region             = "us-east-1"
  cidr_block         = "10.17.0.0/16"
  dmz_subnet_cidrs   = ["10.17.0.0/22", "10.17.4.0/22", "10.17.8.0/22"]
  app_subnet_cidrs   = ["10.17.32.0/19", "10.17.64.0/19", "10.17.96.0/19"]
  data_subnet_cidrs  = ["10.17.128.0/22", "10.17.132.0/22", "10.17.136.0/22"]
  mgmt_subnet_cidrs  = ["10.17.160.0/24", "10.17.161.0/24", "10.17.162.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  owner              = "platform"
}
