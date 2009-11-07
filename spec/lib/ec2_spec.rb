require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe SC::Instance::EC2 do

  before :each do
    SC::Instance::EC2.connect(:access_key_id => 'access key', :secret_access_key => 'secret key')
    FakeWeb.clean_registry
  end

  describe "list" do
    it "should return right number of running instances" do
      FakeWeb.register_uri(:get, %r{Action=DescribeInstances}, :body => api_response('ec2.amazonaws.com', 'list.xml'))
      SC::Instance::EC2.list.length.should == 2
    end

    it "should return right information inside instance" do
      FakeWeb.register_uri(:get, %r{Action=DescribeInstances}, :body => api_response('ec2.amazonaws.com', 'list.xml'))
      SC::Instance::EC2.list.first.instance_id.should == 'i-28a64341'
      SC::Instance::EC2.list[1].instance_id.should == 'i-28a64435'
    end
  end

  describe "create" do
    it "should create new instance" do
      FakeWeb.register_uri(:get, %r{Action=RunInstances}, :body => api_response('ec2.amazonaws.com', 'create.xml'))
      SC::Instance::EC2.create(:ami_id => 'ami-60a54009').first[:aws_state].should == 'pending'
      SC::Instance::EC2.create(:ami_id => 'ami-60a54009').first[:aws_image_id].should == 'ami-60a54009'
    end
  end

end