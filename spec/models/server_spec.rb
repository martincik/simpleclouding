require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Server do
  before(:each) do
    cloud = Cloud.create(:name => 'New cloud', :identity_url => 'test.myopenid.com')
    @valid_attributes = {
      :name => 'Sql server',
      :cloud_id => cloud.id
    }
  end

  it "should create a new instance given valid attributes" do
    Server.create!(@valid_attributes)
  end
end
