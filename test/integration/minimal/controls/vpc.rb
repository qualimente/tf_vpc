require 'awspec'
require 'awsecrets'
require 'json'

require_relative 'spec_helper'

Awsecrets.load()

expect_vpc_name = 'test-vpc'
expect_env = 'test-env'
expect_owner = 'platform'

tf_state_json = json(attribute 'terraform_state', {})
tf_module = get_current_module_from_tf_state_json(tf_state_json)
actual_vpc_id = tf_module['outputs']['vpc.id']['value']

control 'vpc' do

  describe "VPC #{actual_vpc_id}" do
    subject { vpc(actual_vpc_id) }

    it { should exist }
    it { should be_available }

    its(:cidr_block) { should eq '10.17.0.0/16' }

    it { should have_tag('Name').value(expect_vpc_name) }
    it { should have_tag('Environment').value(expect_env) }
    it { should have_tag('Owner').value(expect_owner) }
    it { should have_tag('ManagedBy').value('Terraform') }
  end

  actual_vpc = Aws::EC2::Vpc.new(actual_vpc_id)

  actual_vpc.subnets.each do |actual_subnet|
    describe "subnet: #{actual_subnet.id}" do
      subject { subnet(actual_subnet.id)}

      it { should exist }
      it { should be_available }

      its(:map_public_ip_on_launch) { should be false }

      it { should have_tag('VPCName').value(expect_vpc_name) }
      it { should have_tag('Environment').value(expect_env) }
      it { should have_tag('ManagedBy').value('Terraform') }
    end
  end

  describe "Internet Gateways for #{actual_vpc_id}" do
    actual_igws = actual_vpc.internet_gateways
    its "should have one Internet Gateway"  do
      expect(actual_igws.count).to eq(1)
    end

    actual_igws.each do |actual_igw|
      describe "internet gateway: #{actual_igw.id}" do
        subject {internet_gateway(actual_igw.id)}

        it { should exist }
        
        it { should be_attached_to(actual_vpc_id)}
        
        it { should have_tag('Name').value("igw-#{expect_vpc_name}") }
        it { should have_tag('Environment').value(expect_env) }
        it { should have_tag('ManagedBy').value('Terraform') }
      end
    end
  end

end
