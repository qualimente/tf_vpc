// Instantiate a minimal version of the module for testing
module "it_minimal" {
  source = "../../../" //minimal integration test

  name               = "test-vpc"
  env                = "test-env"
  region             = "us-west-2"
  cidr_block         = "10.17.0.0/16"
  dmz_subnet_cidrs   = ["10.17.0.0/22", "10.17.4.0/22", "10.17.8.0/22"]
  app_subnet_cidrs   = ["10.17.40.0/19", "10.17.72.0/19", "10.17.104.0/19"]
  availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]
  owner              = "platform"
}
