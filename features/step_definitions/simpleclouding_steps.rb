Given /^I am logged in as (.*)$/ do |identity_url|
  
end

Given /^I have created cloud "([^\"]*)"$/ do |cloud_name|
  CloudAmazon.create!(:name => "Amazon", :access_key => 'AKIAIDFDWUQAAFHYSS5Q', :secret_access_key => '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', :identity_url => 'ladislav.martincik@myopenid.com')
end