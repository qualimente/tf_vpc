require 'json'
require 'rspec/expectations'

require_relative 'spec_helper'

tf_state_json = json(attribute 'terraform_state', {})

control 'terraform_state' do
  describe 'the Terraform state file' do
    subject { tf_state_json.terraform_version }

    it('is accessible') { is_expected.to match(/\d+\.\d+\.\d+/) }
  end

  
  describe 'the Terraform state file' do
    #require 'pry'; binding.pry; #uncomment to jump into the debugger

    tf_module = get_current_module_from_tf_state_json(tf_state_json)
    outputs = tf_module['outputs']
    resources = tf_module['resources']

    # describe outputs
    describe 'outputs' do
      describe('VPC') do
        describe('id') do
          subject { outputs['vpc.id']['value'] }
          it { is_expected.to start_with("vpc-") }
        end
        describe('CIDR Block') do
          subject { outputs['vpc.cidr_block'] }
          it { is_expected.to eq({"sensitive" => false, "type" => "string", "value" => "10.17.0.0/16"}) }
        end
      end
    end

    describe 'resources' do
      describe('VPC') do
        vpc_primary = resources['aws_vpc.main']['primary']
        vpc_attributes = vpc_primary['attributes']

        describe('id') do
          subject { vpc_primary['id'] }
          it { is_expected.to eq(outputs['vpc.id']['value']) }
        end

        describe('CIDR Block') do
          subject { vpc_attributes['cidr_block'] }
          it { is_expected.to eq("10.17.0.0/16") }
        end

        describe('Enable ClassicLink') do
          subject { vpc_attributes['enable_classiclink'] }
          it { is_expected.to eq("false") }
        end

        describe('Enable DNS hostnames') do
          subject { vpc_attributes['enable_dns_hostnames'] }
          it { is_expected.to eq("false") }
        end

        describe('Enable DNS Support') do
          subject { vpc_attributes['enable_dns_support'] }
          it { is_expected.to eq("true") }
        end

        describe('Instance Tenancy') do
          subject { vpc_attributes['instance_tenancy'] }
          it { is_expected.to eq("default") }
        end

        describe('Tag: Name') do
          subject { vpc_attributes['tags.Name'] }
          it { is_expected.to eq("test-vpc") }
        end

        describe('Tag: Environment') do
          subject { vpc_attributes['tags.Environment'] }
          it { is_expected.to eq("test-env") }
        end

        describe('Tag: ManagedBy') do
          subject { vpc_attributes['tags.ManagedBy'] }
          it { is_expected.to eq("Terraform") }
        end

        describe('Tag: Owner') do
          subject { vpc_attributes['tags.Owner'] }
          it { is_expected.to eq("platform") }
        end

      end
    end
    
  end

end
