Given /I have running servers in cloud/ do
  # NOTE: For now only mocks
  require 'spec/mocks/methods'
  require 'spec/mocks/extensions/object'
   
  ec2 = Spec::Mocks::Mock.new(:ec2)
  ec2.should_receive(:launch_instances).and_return([{:aws_instance_id => 'instance_id'}])
  ec2.should_receive(:describe_instances).and_return([{:aws_instance_id => 'instance_id'}])
  ec2.should_receive(:describe_key_pairs)
  ec2.should_receive(:terminate_instances).with(["instance_id"])
  ec2.should_receive(:reboot_instances)
  RightAws::Ec2.stub!(:new).and_return(ec2)
  
  cloud = CloudAmazon.create!(:name => "Amazon", 
    :access_key => 'AKIAIDFDWUQAAFHYSS5Q', 
    :secret_access_key => '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', 
    :identity_url => 'ladislav.martincik@myopenid.com')
  Server.create!(:name => 'MySQL server', :cloud_id => cloud.id)
end

Given /I have stubbed external calls for server lunch/ do
  # NOTE: For now only mocks
  require 'spec/mocks/methods'
  require 'spec/mocks/extensions/object'
   
  ec2 = Spec::Mocks::Mock.new(:ec2)
  ec2.should_receive(:launch_instances).and_return([{:aws_instance_id => 'instance_id'}])
  ec2.should_receive(:describe_instances).and_return([{:aws_instance_id => 'instance_id'}])
  RightAws::Ec2.stub!(:new).and_return(ec2)
end

Then /^server "([^\"]*)" created on Amazon$/ do |server_name|
  ec2 = RightAws::Ec2.new('AKIAIDFDWUQAAFHYSS5Q', '9UvTkXgfb8osmh4Q/7jM96gOPkhi7Z3l9pxulFPK')
  ec2.describe_instances.any? do |instance| 
    instance[:aws_instance_id] == Server.find_by_name(server_name).server_attributes[:aws_instance_id]
  end
end