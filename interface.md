
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| app_subnet_cidrs | list of cidr blocks for app subnets | list | - | yes |
| availability_zones | A list of availability zones to deploy the VPC across | list | - | yes |
| cidr_block | The base CIDR block for the VPC; must be a /16 | string | - | yes |
| data_subnet_cidrs | list of cidr blocks for data subnets | list | - | yes |
| dmz_subnet_cidrs | list of cidr blocks for dmz subnets | list | - | yes |
| enable_dns_hostnames | Launch instances in the VPC with public DNS hostnames. Details: http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/vpc-dns.html | string | `false` | no |
| enable_dns_support | Enable Amazon-managed DNS resolvers in the VPC.  Customize via DHCP options. Details: http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/vpc-dns.html | string | `true` | no |
| env | Name of the 'environment' that the VPC supports, e.g. dev | string | - | yes |
| instance_tenancy | Control the tenancy of instances launched in the VPC; default is 'default' for shared hardware. Details: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/dedicated-instance.html | string | `default` | no |
| mgmt_subnet_cidrs | list of cidr blocks for management subnets | list | - | yes |
| name | Name of the VPC | string | - | yes |
| num_vpn_gateways | The number of VPN gateways to provision for the VPC. Set to 1 or more if connecting VPC to a remote datacenter. | string | `0` | no |
| owner | Organizational entity that 'owns' the VPC and is responsible for its care | string | - | yes |
| region | The AWS region in which the VPC will be created. | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| nat_eips |  |
| vpc.cidr_block |  |
| vpc.id |  |
| vpc_endpoint.dynamodb.id |  |
| vpc_endpoint.dynamodb.prefix_list_id |  |
| vpc_endpoint.s3.id |  |
| vpc_endpoint.s3.prefix_list_id |  |

