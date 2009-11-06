require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CloudAmazon do
  before(:each) do
    @valid_attributes = {
      :name => 'New cloud',
      :access_key => 'valid',
      :secret_access_key => 'valid',
      :identity_url => 'testopenid.myopenid.com'
    }
  end

  it "creates a new instance given valid attributes" do
    fake_ec2 = mock(:ec2)
    fake_ec2.should_receive(:describe_key_pairs)
    RightAws::Ec2.stub!(:new).with(@valid_attributes[:access_key], @valid_attributes[:secret_access_key]).and_return(fake_ec2)

    CloudAmazon.create!(@valid_attributes)
  end

  it "dosn't creates a new instance if not valid attributes" do
    RightAws::Ec2.stub!(:new).with(@valid_attributes[:access_key], @valid_attributes[:secret_access_key]).and_raise(RightAws::AwsError.new('test'))

    lambda {
      CloudAmazon.create!(@valid_attributes)
    }.should raise_error(ActiveRecord::RecordInvalid)
  end

end