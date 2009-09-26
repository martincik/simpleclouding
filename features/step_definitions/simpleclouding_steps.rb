Given /^I am logged in as (.*)$/ do |identity_url|
  
end

Given /^I have created cloud "([^\"]*)"$/ do |cloud_name|
  CloudAmazon.create!(:name => "Amazon", :access_key => 'AKIAIDFDWUQAAFHYSS5Q', :secret_access_key => '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', :identity_url => 'ladislav.martincik@myopenid.com')
  #ec2 = mock(:ec2)
  #ec2.should_receive(:launch_instances).and_return([{:aws_reservation_id => 'reservation_id'}])
  #RightAws::Ec2.stub!(:new).and_return(ec2)
end

Then /^server "([^\"]*)" created on Amazon$/ do |server_name|
  ec2 = RightAws::Ec2.new('AKIAIDFDWUQAAFHYSS5Q', '9UvTkXgfb8osmh4Q/7jM96gOPkhi7Z3l9pxulFPK')
  ec2.describe_instances.any? { |instance| instance[:aws_reservation_id] == Server.find_by_name(server_name).reservation_id }
end

#Then /^server "([^\"]*)" created on Amazon$/ do |server_name|
#  Server.find_by_name(server_name).reservation_id.should == 'reservation_id'
#end