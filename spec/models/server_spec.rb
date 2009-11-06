require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Server do
  before(:each) do
    cloud = Cloud.create(:name => 'New cloud', :identity_url => 'test.myopenid.com')
    @valid_attributes = {
      :name => 'Sql server',
      :cloud_id => cloud.id
    }

    @ec2 = mock(:ec2)
    @ec2.should_receive(:launch_instances).and_return([{:aws_instance_id => 'instance_id'}])
    RightAws::Ec2.stub!(:new).and_return(@ec2)
  end

  it "creates a new instance given valid attributes" do
    server = Server.new(@valid_attributes)
    server.save.should be_true
    server.server_attributes.should == {:aws_instance_id => 'instance_id'}
  end

  it "shutdown instance of server before we destroy the object" do
    @ec2.should_receive(:terminate_instances).and_return([{:aws_instance_id => "instance_id"}])
    server = Server.create!(@valid_attributes)
    server.destroy.should be_instance_of(Server)
  end

end
