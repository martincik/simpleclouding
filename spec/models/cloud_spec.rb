require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Cloud do
  before(:each) do
    @valid_attributes = {
      :name => 'New cloud',
      :identity_url => 'test.myopenid.com'
    }
  end

  it "creates a new instance given valid attributes" do
    Cloud.create!(@valid_attributes)
  end

  it "doesn't create a new instance if not given valid attributes" do
    @valid_attributes.delete(:name)
    Cloud.new(@valid_attributes).save.should be_false
  end

  it "returns created clouds for select" do
    cloud = Cloud.create!(@valid_attributes)
    Cloud.all_clouds_for_select.should == {'New cloud' => cloud.id}
  end

end
