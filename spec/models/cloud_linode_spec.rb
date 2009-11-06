require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CloudLinode do
  before(:each) do
    @valid_attributes = {
      :name => 'New cloud',
      :access_key => 'valid',
      :secret_access_key => 'valid',
      :identity_url => 'testopenid.myopenid.com'
    }
  end

  it "creates a new instance given valid attributes" do
    fake_linode = mock(:linode)
    fake_linode.stub!(:test).and_return(fake_linode)
    fake_linode.should_receive(:echo).with(:ping => "pong").and_return(:ping => "pong")
    Linode.stub(:new).and_return(fake_linode)
    CloudLinode.create!(@valid_attributes)
  end

  it "dosn't creates a new instance if not valid attributes" do
    Linode.stub!(:new).with(@valid_attributes[:api_key]).and_raise( Exception.new("test") )
    lambda {
      CloudLinode.create!(@valid_attributes)
    }.should raise_error(ActiveRecord::RecordInvalid)
  end

end