require 'awspec'
require 'awsecrets'

Awsecrets.load()

vpc_name = 'test-vpc'

control 'vpc' do
  describe "VPC #{vpc_name}" do
    subject { vpc(vpc_name) }

    it { should exist }
    it { should be_available }
  end
end
