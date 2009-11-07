require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe SC::Instance::Linode do

  before :each do
    @api_key = 'foo'
    @api_url = 'https://api.linode.com/'

    SC::Instance::Linode.connect(:api_key => @api_key, :api_url => @api_url)
    FakeWeb.clean_registry
  end

  describe "list" do
    it "should return list of linodes" do
      FakeWeb.register_uri(:get, /#{@api_url}(.*)api_action=linode.list/, :body => api_response('api.linode.com', 'list.json'))
      SC::Instance::Linode.list.length.should == 1
      SC::Instance::Linode.list.first.instance_id.should == 8098
    end

    it "should fail if sending wrong params for list" do
      FakeWeb.register_uri(:get, /#{@api_url}(.*)api_action=linode.list/, :body => api_response('api.linode.com', 'auth_failed.json'))
      lambda { SC::Instance::Linode.list }.should raise_error
    end
  end

  describe "create" do
    it "should create new instance" do
      FakeWeb.register_uri(:get, /#{@api_url}(.*)api_action=linode.create/, :body => api_response('api.linode.com', 'create.json'))
      SC::Instance::Linode.create(:DatacenterID => 1, :PlainID => 1, :PaymentTerm => 12).linodeid.should == 8098
    end

    it "should fail if sending wrong params for create" do
      FakeWeb.register_uri(:get, /#{@api_url}(.*)api_action=linode.create/, :body => api_response('api.linode.com', 'auth_failed.json'))
      lambda { SC::Instance::Linode.create }.should raise_error
    end
  end

  describe "destory" do
    it "should destroy instace" do
      FakeWeb.register_uri(:get, /#{@api_url}(.*)api_action=linode.delete/, :body => api_response('api.linode.com', 'destroy.json'))
      SC::Instance::Linode.new(:instance_id => 1).destroy.linodeid.should == 8204
    end

    it "should fail if sending wrong params for destroy" do
      FakeWeb.register_uri(:get, /#{@api_url}(.*)api_action=linode.delete/, :body => api_response('api.linode.com', 'auth_failed.json'))
      lambda { SC::Instance::Linode.new.destroy }.should raise_error
    end
  end

  describe "reboot" do
    it "should reboot instace" do
      FakeWeb.register_uri(:get, /#{@api_url}(.*)api_action=linode.reboot/, :body => api_response('api.linode.com', 'reboot.json'))
      SC::Instance::Linode.new(:instance_id => 1).reboot.jobid.should == 1295
    end

    it "should fail if sending wrong params for reboot" do
      FakeWeb.register_uri(:get, /#{@api_url}(.*)api_action=linode.reboot/, :body => api_response('api.linode.com', 'auth_failed.json'))
      lambda { SC::Instance::Linode.new.reboot }.should raise_error
    end
  end

end