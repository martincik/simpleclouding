class Aws::AwsController < ApplicationController
  
  before_filter :login_required
  before_filter :setup_tabs
  before_filter :setup_awstab
  
  attr_reader :awstab_name
  
  protected
  
    def setup_tabs
      @tab_name = 'clouds'
    end
    
    def setup_awstab
      raise RuntimeError.new("Each AWS controller has to implement setup_awstab method!")
    end
  
end