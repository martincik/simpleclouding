require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe SC::Instance::EC2 do

  before :each do
    SC::Instance::EC2.connect(:access_key_id => 'access key', :secret_access_key => 'secret key')
    FakeWeb.clean_registry
  end

  describe "list" do
    it "returns number of running instances" do
      FakeWeb.register_uri(:get, %r{Action=DescribeInstances}, :body => api_response('ec2.amazonaws.com', 'list.xml'))
      SC::Instance::EC2.list.length.should == 2
    end

    it "returns information about instance" do
      FakeWeb.register_uri(:get, %r{Action=DescribeInstances}, :body => api_response('ec2.amazonaws.com', 'list.xml'))
      SC::Instance::EC2.list.first.instance_id.should == 'i-28a64341'
      SC::Instance::EC2.list[1].instance_id.should == 'i-28a64435'
    end
  end

  it "creates new instance" do
    FakeWeb.register_uri(:get, %r{Action=RunInstances}, :body => api_response('ec2.amazonaws.com', 'create.xml'))
    SC::Instance::EC2.create(:ami_id => 'ami-60a54009').first[:aws_state].should == 'pending'
    SC::Instance::EC2.create(:ami_id => 'ami-60a54009').first[:aws_image_id].should == 'ami-60a54009'
  end

  it "reboots instance" do
    FakeWeb.register_uri(:get, %r{Action=RebootInstances}, :body => api_response('ec2.amazonaws.com', 'reboot.xml'))
    SC::Instance::EC2.new(:instance_id => 1).reboot.should be_true
  end

  it "reboots instance" do
    FakeWeb.register_uri(:get, %r{Action=TerminateInstances}, :body => api_response('ec2.amazonaws.com', 'terminate.xml'))
    SC::Instance::EC2.new(:instance_id => "i-3ea74257").destroy.first[:aws_shutdown_state].should  == 'shutting-down'
  end

end