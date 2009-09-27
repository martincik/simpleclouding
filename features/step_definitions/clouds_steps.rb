Given /^I have created cloud "([^\"]*)"$/ do |cloud_name|
  CloudAmazon.create!(:name => cloud_name, 
    :access_key => 'AKIAIDFDWUQAAFHYSS5Q', 
    :secret_access_key => '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', 
    :identity_url => 'ladislav.martincik@myopenid.com')
end

Then /^I follow delete link for security group "([^\"]*)"$/ do |security_group_name|
  require 'ruby-debug'
  debugger
  parent = Webrat::nokogiri_document(response).search("#cloud-security-group a.destroy").select { |el| 
    !el[:href][CGI.escape(security_group_name)].nil? 
  }
  #parent = find_link('Delete').select { |element|  }
  click_link_within(parent.first, "Delete")
end 