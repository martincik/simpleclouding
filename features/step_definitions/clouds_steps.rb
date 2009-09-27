Given /^I have created cloud "([^\"]*)"$/ do |cloud_name|
  CloudAmazon.create!(:name => cloud_name, 
    :access_key => 'AKIAIDFDWUQAAFHYSS5Q', 
    :secret_access_key => '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', 
    :identity_url => 'ladislav.martincik@myopenid.com')
end