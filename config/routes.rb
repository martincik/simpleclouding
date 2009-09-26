ActionController::Routing::Routes.draw do |map|
  map.openid_login '/login', :controller => :openid, :action => :new
  
  map.home '/', :controller => 'dashboard', :action => 'index'
  
  map.resources :clouds
  map.resources :servers
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
