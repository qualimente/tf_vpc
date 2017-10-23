require 'awspec'
require 'awsecrets'

Awsecrets.load()

vpc_name = 'test-vpc'
env = 'test-env'
owner = 'platform'

control 'vpc' do
  describe "VPC #{vpc_name}" do
    subject { vpc(vpc_name) }

    it { should exist }
    it { should be_available }

    its(:cidr_block) { should eq '10.17.0.0/16' }

    it { should have_tag('Name').value(vpc_name) }
    it { should have_tag('Environment').value(env) }
    it { should have_tag('Owner').value(owner) }
    it { should have_tag('ManagedBy').value('Terraform') }
  end
end
