config {
  terraform_version = "0.9.11"
  deep_check = true

  aws_credentials = {
    region     = "us-east-1"
  }

  ignore_rule = {
    //ignore checking of routes to gateways becuase tflint is identifying
    //ERROR:58 "${aws_internet_gateway.main.id}" is invalid internet gateway ID. (aws_route_invalid_gateway)
    //and it should be ignoring this eval because the id is interpolated
    aws_route_invalid_gateway  = true
  }

  varfile = ["test/fixtures/minimal/minimal.tfvars"]
}