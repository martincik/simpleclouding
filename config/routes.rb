ActionController::Routing::Routes.draw do |map|
  map.openid_login '/login', :controller => :openid, :action => :new
  
  map.home '/', :controller => 'dashboard', :action => 'index'
  
  map.resources :servers, :member => { :restart => :get }
  map.resources :clouds, :collection => { :cloud_options => :get } do |cloud|
    cloud.namespace :aws, :name_prefix => 'cloud_aws_' do |aws|
      aws.resources :security_groups, :as => 'aws/security_groups'
      aws.resources :key_pairs,       :as => 'aws/key_pairs'
      aws.resource  :default_zone,    :as => 'aws/default_zone'
    end
  end
  
  # AWS => Security Groups
  map.show_cloud_aws_security_group 'clouds/:cloud_id/aws/security_groups/show',
    :controller => 'aws/security_groups', :action => 'show',
    :conditions => { :method => :get }
  
  map.cloud_aws_security_group 'clouds/:cloud_id/aws/security_groups/destroy',
    :controller => 'aws/security_groups', :action => 'destroy',
    :conditions => { :method => :delete }
  
  # AWS => Key Pairs
  map.show_cloud_aws_key_pair 'clouds/:cloud_id/aws/key_pairs/show',
    :controller => 'aws/key_pairs', :action => 'show',
    :conditions => { :method => :get }
  
  map.cloud_aws_key_pair 'clouds/:cloud_id/aws/key_pairs/destroy',
    :controller => 'aws/key_pairs', :action => 'destroy',
    :conditions => { :method => :delete }
  
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
