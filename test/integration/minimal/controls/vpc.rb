require 'awspec'
require 'awsecrets'
require 'json'

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

end
